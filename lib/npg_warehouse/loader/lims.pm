package npg_warehouse::loader::lims;

use Carp;
use Moose;
use English qw{-no_match_vars};
use DateTime;
use st::api::lims;
use Readonly;

our $VERSION = '0';

Readonly::Scalar our $LOOKBACK_NUM_DAYS => 50;

=head1 NAME

npg_warehouse::loader::lims

=head1 SYNOPSIS

 my $id_run = 222;
 my $rl_hash = npg_:warehouse::loader::lims->new(plex_key=>q[plex])->retrieve($id_run);

=head1 DESCRIPTION

Retrieves LIMS data for loading to the warehouse

=head1 SUBROUTINES/METHODS

=cut


=head2 verbose

Verbose flag

=cut
has 'verbose'      => ( isa        => 'Bool',
                        is         => 'ro',
                        required   => 0,
                        default    => 0,
                      );


=head2 recent

Flag to tell whether to retrieve data for only recent or all runs.

=cut
has 'recent' =>          ( isa        => 'Bool',
                            is         => 'ro',
                            required   => 0,
                            default    => 1,
                          );

=head2 plex_key

Name of the key to use in data structures for plex data.

=cut
has 'plex_key' =>   ( isa             => 'Str',
                      is              => 'ro',
                      required        => 1,
		    );

=head2 dev_cost_codes

R&D cost codes.

=cut
has 'dev_cost_codes' =>   ( isa             => 'Maybe[ArrayRef]',
                            is              => 'ro',
                            required        => 0,
		          );
has '_dev_cost_codes_h' =>   ( isa             => 'HashRef',
                               is              => 'ro',
                               required        => 0,
                               lazy_build      => 1,
		             );
sub _build__dev_cost_codes_h {
    my $self = shift;
    my $h = {};
    if ($self->dev_cost_codes) {
        foreach my $code (@{$self->dev_cost_codes}) {
            $h->{$code} = 1;
        }
    }
    return $h;
}

has '_projects_index' => ( isa             => 'HashRef',
                           is              => 'rw',
                           default         => sub { return {}; },
		         );

=head2 is_recent

Returns 1 if run is considered recent, 0 otherwise

=cut
sub is_recent {
    my ($self, $date) = @_;
    if (!$self->recent) {return 1;}
    if (!$date) {
        carp q[Warning: no date to evaluate];
        return 0;
    }
    my $dt = DateTime->now(time_zone => 'floating');
    $dt->subtract(days => $LOOKBACK_NUM_DAYS);
    if ( $date > $dt ) {
	return 1;
    }
    return 0;
}

=head2 lane_type

Lane type for an st::api::lims object (as either library, control, or pool)

=cut
sub lane_type {
    my ($self, $lims) = @_;
    if ($lims->is_control) {
        return q[control];
    }
    if ($lims->is_pool) {
        return q[pool];
    }
    return q[library];
}

=head2 is_dev_cost_code

Returns a boolean value (0 or 1) indicating whether the cost code for
projects in a lims object is R&D. For a pool, rerurns 1 if at least
one plex in a pool has R&D cost code.

=cut
sub is_dev_cost_code {
    my ($self, $lims) = @_;

    if (!$self->dev_cost_codes) { return 0; }

    my @lims_all = $lims->is_pool ? $lims->children : ($lims);
    foreach my $l (@lims_all) {
        my $id = $l->project_id;
        if (!$id) { next; }

        my $code;
        if (exists $self->_projects_index->{$id}) {
 	    $code = $self->_projects_index->{$id};
        } else {
 	    $code = $l->project_cost_code;
            $self->_projects_index->{$id} = $code;
        }
        if ($code && exists $self->_dev_cost_codes_h->{$code}) {
	    return 1;
	}
    }
    return 0;
}

=head2 retrieve

LIMS for a run

=cut
sub retrieve {
    my ($self, $batch_id, $date, $is_cancelled, $run_is_indexed) = @_;

    my $info = {};

    if ( $batch_id == 0 || !$self->is_recent($date) ) { return $info; }

    my @alims;
    eval {
	@alims = st::api::lims->new(batch_id => $batch_id)->associated_lims;
        1;
    } or do {
        my $err = $EVAL_ERROR;
        if ( $err =~ /404\ Not\ Found/smx ) {
            carp qq[Warning: $err];
	} else {
            croak $err;
	}
    };

    foreach my $lims ( @alims ) {

        my $position = $lims->position;
        my $tag_index = $lims->tag_index;
        my $attrs = _common_attrs($lims, $run_is_indexed);

        if (!defined $tag_index) {  # lane level object
            $info->{$position} = $attrs;
            $info->{$position}->{manual_qc}  = !$is_cancelled ? $lims->seq_qc_state : undef;
            $info->{$position}->{is_dev}     = $self->is_dev_cost_code($lims);
            $info->{$position}->{lane_type}  = $self->lane_type($lims);
            if ($lims->spiked_phix_tag_index) {
              $info->{$position}->{spike_tag_index}  = $lims->spiked_phix_tag_index;
	    }
	    $info->{$position}->{request_id} = $lims->request_id;
        } else { # plex level object
	    $info->{$position}->{$self->plex_key}->{$tag_index} = $attrs;
        }
    }
    return $info;
}

=head2 retrieve_manual_qc

Retrieves just the manual qc data from batch.

=cut

sub retrieve_manual_qc {
    my ($self, $batch_id) = @_;
    my $info = {};
    foreach my $lims ( st::api::lims->new(batch_id => $batch_id)->children ) {
        $info->{$lims->position}->{'manual_qc'} = $lims->seq_qc_state;
    }
    return $info;
}

sub _common_attrs {
    my ($lims, $run_is_indexed) = @_;
    my $with_spiked_control = 0;
    my @project_ids   = $lims->project_ids($with_spiked_control);
    my @study_ids     = $lims->study_ids($with_spiked_control);
    my @library_types = $lims->library_types();
    my $h = {
        asset_id     => $lims->library_id   || undef,
        sample_id    => $lims->sample_id    || undef,
        asset_name   => $lims->library_name || undef,
        study_id     => scalar @study_ids     == 1 ? $study_ids[0]     : ($lims->study_id     || undef),
        project_id   => scalar @project_ids   == 1 ? $project_ids[0]   : ($lims->project_id   || undef),
        library_type => scalar @library_types == 1 ? $library_types[0] : ($lims->library_type || undef),
    };

    if (!$run_is_indexed && !defined $lims->tag_index) {
        my @children = grep {
          !$lims->spiked_phix_tag_index || ($_->tag_index != $lims->spiked_phix_tag_index)
        } $lims->children;
        if (@children && scalar @children == 1) {
	    $h->{'asset_id'}   = $children[0]->library_id;
            $h->{'asset_name'} = $children[0]->library_name || undef;
        }
    }

    return $h;
}

__PACKAGE__->meta->make_immutable;

1;
__END__


=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Carp

=item Readonly

=item English

=item Moose

=item DateTime

=item st::api::lims

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2016 GRL

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut
