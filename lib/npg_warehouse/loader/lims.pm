package npg_warehouse::loader::lims;

use Moose;
use namespace::autoclean;
use List::MoreUtils qw/all/;

our $VERSION = '0';

=head1 NAME

npg_warehouse::loader::lims

=head1 SYNOPSIS

 my $data_hash = npg_:warehouse::loader::lims->new(
                 plex_key => q[plex],
                 lims     => $lims_obj)->retrieve($is_indexed);

=head1 DESCRIPTION

Retrieves LIMs data for one run. Returns data in a format ready
for loading to the warehouse.

=head1 SUBROUTINES/METHODS

=cut

=head2 lims

Run-level st::api::lims object, required.

=cut
has 'lims' => ( isa        => 'st::api::lims',
                is         => 'ro',
                required   => 1,
              );

=head2 plex_key

Name of the key to use in the hash returned by retrieve() for plex data.

=cut
has 'plex_key' => ( isa             => 'Str',
                    is              => 'ro',
                    required        => 1,
		              );

=head2 retrieve

Returns LIMSs data as a hash ready for loading to the warehouse.

=cut
sub retrieve {
  my ($self, $run_is_indexed) = @_;

  my $info  = {};
  my @alims = $self->lims()->associated_lims();

  foreach my $lims ( $self->lims()->associated_lims() ) {
    my $position  = $lims->position;
    my $tag_index = $lims->tag_index;
    my $attrs = _common_attrs($lims, $run_is_indexed, \@alims);

    if (!defined $tag_index) {  # lane level object
      $info->{$position} = $attrs;
      $info->{$position}->{'lane_type'}  = $lims->is_control ? q[control] :
                ($lims->is_pool ? q[pool] : q[library]);
      if ($lims->spiked_phix_tag_index) {
        $info->{$position}->{'spike_tag_index'}  = $lims->spiked_phix_tag_index;
	    }
    } else { # plex level object
	    $info->{$position}->{$self->plex_key}->{$tag_index} = $attrs;
    }
  }

  return $info;
}

sub _lib2asset_id {
  my $lib_id = shift;
  return $lib_id && $lib_id =~ /\A\d+\Z/smx ? $lib_id : undef;
}

sub _common_attrs {
  my ($lims, $run_is_indexed, $all_lims) = @_;

  my $with_spiked_control = 0;
  my @study_ids     = $lims->study_ids($with_spiked_control);
  my @library_types = $lims->library_types($with_spiked_control);
  my $h = {};
  $h->{'asset_id'}     = _lib2asset_id($lims->library_id);
  $h->{'asset_name'}   = $lims->library_name;
  $h->{'sample_id'}    = $lims->sample_id || undef;
  $h->{'study_id'}     = scalar @study_ids     == 1 ? $study_ids[0]     :
                          ($lims->study_id     || undef);
  $h->{'library_type'} = scalar @library_types == 1 ? $library_types[0] :
                          ($lims->library_type || undef);

  if (!defined $lims->tag_index) {
    my @children = grep {
      ($_->position() == $lims->position) && (defined $_->tag_index) && !$_->is_control()
    } @{$all_lims};

    $h->{'manual_qc'} = $lims->seq_qc_state();
    if (@children) {
      if (!defined $h->{'manual_qc'}) {
	      my @qc_states = map {$_->qc_state} grep {defined $_->qc_state} @children;
        # If all plexes have been qc-ed
        if (@qc_states == @children) {
		      $h->{'manual_qc'} = (all {$_->qc_state == 0} @children) ? 0 : 1;
	      }
	    }
      if (!$run_is_indexed && scalar @children == 1) {
	      $h->{'asset_id'}   = _lib2asset_id($children[0]->library_id);
        $h->{'asset_name'} = $children[0]->library_name;
      }
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

=item List::MoreUtils

=item namespace::autoclean

=item Moose

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2017 Genome Research Ltd.

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
