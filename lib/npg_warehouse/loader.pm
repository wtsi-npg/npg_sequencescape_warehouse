package npg_warehouse::loader;

use Carp;
use namespace::autoclean;
use Moose;
use MooseX::StrictConstructor;
use List::MoreUtils qw/none uniq/;
use Readonly;
use Try::Tiny;

use npg_warehouse::Schema;
use npg_tracking::Schema;
use npg_qc::Schema;
use WTSI::DNAP::Warehouse::Schema;
use npg_qc::autoqc::qc_store;
use st::api::lims;
use npg_warehouse::loader::autoqc;
use npg_warehouse::loader::lims;
use npg_warehouse::loader::qc;
use npg_warehouse::loader::npg;
use npg_warehouse::loader::run_status;

with 'MooseX::Getopt';

our $VERSION = '0';

Readonly::Scalar my $FORWARD_END_INDEX        => 1;
Readonly::Scalar my $REVERSE_END_INDEX        => 2;
Readonly::Scalar my $PLEXES_KEY               => q[plexes];
Readonly::Scalar my $DEFAULT_LIMS_DRIVER      => q[ml_warehouse_fc_cache];
# Data for runs with no or zero batch id and with run id larger than
# this value will not be loaded - likely to be GCLP runs, whose LIMs
# ids are strings and, therefore, cannot be loaded to this schema.
Readonly::Scalar my $MAX_RUN_WITH_NO_BATCH_ID => 10_000;

=head1 NAME

npg_warehouse::loader

=head1 SYNOPSIS

 npg_warehouse::loader->new()->load();
 npg_warehouse::loader->new(id_run => [5566, 6655])->load(); 

=head1 DESCRIPTION

A module that loads data to the old sequencescape warehouse.
The source of LIMs data is defined by the lims_driver_type attributes
that defaults to ml_warehouse_fc_cache.

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

=head2 run_statuses

Flag to load run statuses, false by default

=cut
has 'run_statuses' => ( isa        => 'Bool',
                        is         => 'ro',
                        required   => 0,
                        default    => 0,
                      );

=head2 lims_driver_type

An optional LIMs driver type as defined in st::api::lims.

=cut
has 'lims_driver_type' => ( isa        => 'Str',
                            is         => 'ro',
                            required   => 0,
                            default    => $DEFAULT_LIMS_DRIVER,
                          );

=head2 id_run

An array ref of run ids that have to be loaded. If not set
or empty, all runs will be loaded.

=cut
has 'id_run'        =>    ( isa      => 'ArrayRef[Int]',
                            is       => 'ro',
                            required => 0,
                            default  => sub { return []; },
                          );

has '_schema_wh'  =>  ( isa        => 'npg_warehouse::Schema',
                        is         => 'ro',
                        required   => 0,
                        lazy_build => 1,
                      );
sub _build__schema_wh {
    return npg_warehouse::Schema->connect();
}

has '_schema_npg' =>  ( isa        => 'npg_tracking::Schema',
                        is         => 'ro',
                        required   => 0,
                        lazy_build => 1,
                      );
sub _build__schema_npg {
    return npg_tracking::Schema->connect();
}

has '_schema_qc' =>   ( isa        => 'npg_qc::Schema',
                        is         => 'ro',
                        required   => 0,
                        lazy_build => 1,
                      );
sub _build__schema_qc {
    return npg_qc::Schema->connect();
}

has '_autoqc_store' =>    ( isa        => 'npg_qc::autoqc::qc_store',
                            is         => 'ro',
                            required   => 0,
                            lazy_build => 1,
                           );
sub _build__autoqc_store {
    my $self = shift;
    return npg_qc::autoqc::qc_store->new(use_db    => 1,
                                         verbose   => $self->verbose,
                                         qc_schema => $self->_schema_qc);
}

has '_schema_mlwarehouse' => ( isa        => 'WTSI::DNAP::Warehouse::Schema',
                               is         => 'ro',
                               required   => 0,
                               lazy_build => 1,
                             );
sub _build__schema_mlwarehouse {
    return WTSI::DNAP::Warehouse::Schema->connect();
}

has '_run_lane_rs' =>     ( isa        => 'DBIx::Class::ResultSet',
                            is         => 'ro',
                            required   => 0,
                            lazy_build => 1,
                          );
sub _build__run_lane_rs {
    my $self = shift;
    my $where = {};
    if (@{$self->id_run}) {
        $where->{q[me.id_run]} = $self->id_run;
    }
    my $all_rs = $self->_schema_npg->resultset('RunLane')->search(
        $where,
        {
            prefetch => q[run],
            order_by => [q[run.batch_id], q[me.id_run], q[me.position]],
        },
    );
    return $all_rs;
}

sub _create_lims_retriever {
    my ($self, $id_run, $batch_id) = @_;

    my $ref = {
        id_run      => $id_run,
        driver_type => $self->lims_driver_type()
    };
    if ($self->lims_driver_type() =~ 'ml_warehouse') {
        $ref->{'mlwh_schema'} = $self->_schema_mlwarehouse();
    } elsif ($self->lims_driver_type() eq 'xml') {
        $ref->{'batch_id'} = $batch_id;
    }

    return npg_warehouse::loader::lims->new(
            lims     => st::api::lims->new($ref),
            plex_key => $PLEXES_KEY
    );
}

=head2 npg_data

Retrieves data for one run. Returns per-table hashes of key-value pairs that
are suitable for use in updating/creating rows with DBIx.

=cut
sub npg_data { ##no critic (Subroutines::ProhibitExcessComplexity)
    my ($self, $lanes, $id_run) = @_;

    my $end = $lanes->[0]->run->id_run_pair ? $REVERSE_END_INDEX : $FORWARD_END_INDEX;

    my $run_retriever =  npg_warehouse::loader::npg->new(
        schema_npg => $self->_schema_npg,
        verbose    => $self->verbose,
        id_run     => $id_run);

    my $run_is_cancelled = $run_retriever->run_is_cancelled();
    my $run_is_paired_read = $run_retriever->run_is_paired_read();
    my $run_is_indexed = $run_retriever->run_is_indexed();
    my $dates = $run_retriever->dates();
    my $instr = $run_retriever->instrument_info;

    my $run_autoqc         = {};
    my $forward_id_run = $id_run;
    if( $lanes->[0]->run->id_run_pair ) {
        $forward_id_run = $lanes->[0]->run->id_run_pair;
    } else {
        if (!$run_is_cancelled) {
            $run_autoqc = npg_warehouse::loader::autoqc->new(
                autoqc_store => $self->_autoqc_store,
            )->retrieve($forward_id_run, $self->_schema_npg);
        }
    }

    my $qc_retriever = npg_warehouse::loader::qc->new(
                       schema_qc => $self->_schema_qc);
    my $run_cluster_density = $qc_retriever->retrieve_cluster_density($id_run);

    my $batch_id = $lanes->[0]->run->batch_id;
    my $run_lane_info = {};
    try {
        $run_lane_info = $self->_create_lims_retriever($id_run, $batch_id)
                              ->retrieve($run_is_indexed);
    } catch {
        if ($self->verbose) {
            carp qq[Failed to retrieve LIMS data for run $id_run : $_];
        }
    };

    my $lane_values = {};
    my $plex_values = {};

    foreach my $rs (@{$lanes})  {

        my $position                  = $rs->position;

        my $values = {};
        $values->{id_run}             = $id_run;
        $values->{batch_id}           = $batch_id;
        $values->{position}           = $position;
        $values->{id_run_pair}        = $rs->run->id_run_pair;
        $values->{cycles}             = $rs->run->actual_cycle_count;
        $values->{has_two_runfolders} = $rs->run->is_paired;
        $values->{cancelled}          = $run_is_cancelled;
        $values->{paired_read}        = $run_is_paired_read;
        $values->{instrument_name}    = $instr->{name};
        $values->{instrument_model}   = $instr->{model};

        foreach my $event_type (keys %{$dates}) {
            $values->{$event_type} = $dates->{$event_type};
        }

        my $lane_cluster_density = exists $run_cluster_density->{$position} ?
                                          $run_cluster_density->{$position} : {};
        foreach my $column (keys %{$lane_cluster_density}) {
            $values->{$column} = $lane_cluster_density->{$column};
        }

        $plex_values->{$position} = {};

        if (exists $run_lane_info->{$position} ) {
            foreach my $column (keys %{$run_lane_info->{$position}}) {
            ##no critic (ControlStructures::ProhibitDeepNests)
                if ( $column eq $PLEXES_KEY) {
                    if ($run_is_indexed) {
                        $plex_values->{$position} = $run_lane_info->{$position}->{$PLEXES_KEY};
                        foreach my $ti (keys %{$run_lane_info->{$position}->{$PLEXES_KEY}}) {
                            $plex_values->{$position}->{$ti}->{batch_id}  = $batch_id;
                            $plex_values->{$position}->{$ti}->{id_run}    = $id_run;
                            $plex_values->{$position}->{$ti}->{position}  = $position;
                            $plex_values->{$position}->{$ti}->{tag_index} = $ti;
                        }
                    }
                } else {
                    $values->{$column} = $run_lane_info->{$position}->{$column};
                }
            }
        }

        $lane_values->{$position} = $values;
    }

    foreach my $digest (keys %{$run_autoqc}) {
        my $values = $run_autoqc->{$digest};
        my $composition = delete $values->{'composition'};
        if ($composition->num_components > 1) {
            next;
        }
        my $component = $composition->get_component(0);
        my $position  = $component->position;
        my $tag_index = $component->tag_index;
        if (defined $tag_index) {
            if ($run_is_indexed) {
                if (!exists $plex_values->{$position}->{$tag_index}) {
                    $values->{id_run}    = $id_run;
                    $values->{position}  = $position;
                    $values->{tag_index} = $tag_index;
                    $values->{batch_id}  = $batch_id;
                }
                while (my ($column_name, $value) = each %{$values}) {
                    $plex_values->{$position}->{$tag_index}->{$column_name} = $value;
                }
            }
        } else {
            while (my ($column_name, $value) = each %{$values}) {
                $lane_values->{$position}->{$column_name} = $value;
            }
        }
    }

    return {NpgInformation     => [values %{$lane_values}],
            NpgPlexInformation => [map { values %{$_} } values %{$plex_values}]};
}

=head2 load_run

Load data for one run to the warehouse.

=cut
sub load_run {
    my ($self, $table_name, $rows, $id_run) = @_;

    if (!defined $rows || !@{$rows}) {return;}

    my $transaction = sub {
        my $rs_in = $self->_schema_wh->resultset($table_name);
        my @column_names = $rs_in->result_source->columns;
        foreach my $row (@{$rows}) {
            if($self->verbose) {
                my $message =  q[Updating or creating row for batch ] .
                    $row->{batch_id} . qq[ run $id_run position ] . $row->{position};
                if ($table_name =~ /plex/ismx) {
                    $message .= q[ tag_index ] . $row->{tag_index};
                }
                carp $message;
            }
            for my $key (keys %{$row}) {
                if ( none { $_ eq $key} @column_names) {
                    delete $row->{$key};
                }
            }
            $rs_in->update_or_create($row);
        }
    };

    try {
        $self->_schema_wh->txn_do($transaction);
    } catch {
        my $err = $_;
        if ($err =~ /Rollback failed/sxm) {
            croak $err;
        }
        carp "Failed to load $id_run to $table_name: $err";
    };

    return;
}


=head2 retrieve_load_run

Retrieve data for one run and load these data to the warehouse

=cut
sub retrieve_load_run {
    my ($self, $run_lanes, $id_run) = @_;

    if (!@{$run_lanes}) {
      return;
    }
    (scalar uniq map { $_->id_run } @{$run_lanes}) == 1 or croak 'Incorrect list of lanes';

    try {
        my $data = $self->npg_data($run_lanes, $id_run);
        foreach my $table_name (sort keys %{$data}) {
            $self->load_run($table_name, $data->{$table_name}, $id_run);
        }
    } catch {
        carp "Failed to retrieve and load $id_run: $_";
    };
    return;
}

=head2 load

The top level method to call when loading npg data to the warehouse db.

=cut
sub load {
    my ($self) = @_;

    my $all_rs = $self->_run_lane_rs;
    my $rs = $all_rs->next;
    if (!$rs) { return; }

    my @run_lanes = ();
    my $previous_id_run = $rs->run->id_run;
    my $id_run;
    while ($rs) {
        my $skip = 0;
        $id_run = $rs->run->id_run;
        my $batch_id = $rs->run->batch_id;
        if (!$batch_id && $id_run > $MAX_RUN_WITH_NO_BATCH_ID) {
            if ($self->verbose) {
                carp "Skipping run $id_run";
            }
            $skip = 1;
        }
        if($id_run != $previous_id_run) {
            $self->retrieve_load_run(\@run_lanes, $previous_id_run);
            @run_lanes = ();
            $previous_id_run = $id_run;
        }
        if (!$skip) {
            push @run_lanes, $rs;
        }

        $rs = $all_rs->next;
    }

    $self->retrieve_load_run(\@run_lanes, $previous_id_run);

    return;
}

=head2 update_run_statuses

Copies run statuses from npg tracking database

=cut
sub update_run_statuses {
    my $self = shift;
    npg_warehouse::loader::run_status->new(schema_npg => $self->_schema_npg,
                                           schema_wh  => $self->_schema_wh)->copy_npg_tables;
    return;
}

=head2 run

Calls one of the loaders

=cut
sub run {
    my $self = shift;
    if (defined $ENV{dev} && $ENV{dev}) {
        warn 'USING ' . $ENV{dev} . " DATABASES\n";
    }
    $self->run_statuses ? $self->update_run_statuses() : $self->load();
    if ($self->verbose) {
        warn "Completed loading, exiting...\n";
    }
    return;
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

=item namespace::autoclean

=item Moose

=item MooseX::StrictConstructor

=item List::MoreUtils

=item npg_warehouse::Schema

=item npg_tracking::Schema

=item npg_qc::Schema

=item npg_qc::autoqc::qc_store

=item st::api::lims

=item WTSI::DNAP::Warehouse::Schema

=item npg_warehouse::loader::autoqc

=item npg_warehouse::loader::qc

=item npg_warehouse::loader::lims

=item npg_warehouse::loader::npg

=item npg_warehouse::loader::run_status

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
