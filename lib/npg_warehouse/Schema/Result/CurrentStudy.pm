
package npg_warehouse::Schema::Result::CurrentStudy;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

##no critic(RequirePodAtEnd RequirePodLinksIncludeText ProhibitMagicNumbers ProhibitEmptyQuotes)

=head1 NAME

npg_warehouse::Schema::Result::CurrentStudy

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components('InflateColumn::DateTime');

=head1 TABLE: C<current_studies>

=cut

__PACKAGE__->table('current_studies');

=head1 ACCESSORS

=head2 uuid

  data_type: 'binary'
  is_nullable: 0
  size: 16

=head2 internal_id

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 reference_genome

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ethically_approved

  data_type: 'tinyint'
  is_nullable: 1

=head2 faculty_sponsor

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 state

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 study_type

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 abstract

  data_type: 'text'
  is_nullable: 1

=head2 abbreviation

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 is_current

  data_type: 'tinyint'
  is_nullable: 0

=head2 checked_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 contains_human_dna

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 contaminated_human_dna

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 data_release_strategy

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 data_release_sort_of_study

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ena_project_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 study_title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 study_visibility

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ega_dac_accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 array_express_accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ega_policy_accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 inserted_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 deleted_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 current_from

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 current_to

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 data_release_timing

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 data_release_delay_period

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 data_release_delay_reason

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 remove_x_and_autosomes

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 alignments_in_bam

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 0

=head2 separate_y_chromosome_data

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 data_access_group

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 prelim_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 hmdmc_number

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  'uuid',
  { data_type => 'binary', is_nullable => 0, size => 16 },
  'internal_id',
  { data_type => 'integer', is_nullable => 0 },
  'name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'reference_genome',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ethically_approved',
  { data_type => 'tinyint', is_nullable => 1 },
  'faculty_sponsor',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'state',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'study_type',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'abstract',
  { data_type => 'text', is_nullable => 1 },
  'abbreviation',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'description',
  { data_type => 'text', is_nullable => 1 },
  'is_current',
  { data_type => 'tinyint', is_nullable => 0 },
  'checked_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'last_updated',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'created',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'contains_human_dna',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'contaminated_human_dna',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'data_release_strategy',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'data_release_sort_of_study',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ena_project_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'study_title',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'study_visibility',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ega_dac_accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'array_express_accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ega_policy_accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'inserted_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'deleted_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'current_from',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'current_to',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'data_release_timing',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'data_release_delay_period',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'data_release_delay_reason',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'remove_x_and_autosomes',
  { data_type => 'tinyint', default_value => 0, is_nullable => 0 },
  'alignments_in_bam',
  { data_type => 'tinyint', default_value => 1, is_nullable => 0 },
  'separate_y_chromosome_data',
  { data_type => 'tinyint', default_value => 0, is_nullable => 0 },
  'data_access_group',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'prelim_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'hmdmc_number',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<internal_id_idx>

=over 4

=item * L</internal_id>

=back

=cut

__PACKAGE__->add_unique_constraint('internal_id_idx', ['internal_id']);

=head2 C<uuid_idx>

=over 4

=item * L</uuid>

=back

=cut

__PACKAGE__->add_unique_constraint('uuid_idx', ['uuid']);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-29 10:46:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ma0T9vVVx+JcXihsHcMwbQ

our $VERSION = '0';

sub study_name {
    my $self = shift;
    return $self->name || $self->internal_id;
}

sub sample_ids {
    my $self = shift;
    my $rs = $self->result_source->schema->resultset(q[CurrentStudySample])->search(
      { study_internal_id => $self->internal_id,
        sample_internal_id => {q[!=] => undef,},
      },
      {
        columns => [qw/sample_internal_id/],
        distinct => 1,
      },
    );
    my @samples = ();
    while (my $srow = $rs->next) {
        push @samples, $srow->sample_internal_id;
    }
    return \@samples;
}

=head2 npg_information

Type: has_many

Related object: L<npg_warehouse::Schema::Result::NpgInformation>

=cut

__PACKAGE__->has_many(
  'npg_information',
  'npg_warehouse::Schema::Result::NpgInformation',
  { 'foreign.study_id' => 'self.internal_id'  },
);

=head2 npg_plex_information

Type: has_many

Related object: L<npg_warehouse::Schema::Result::NpgPlexInformation>

=cut

__PACKAGE__->has_many(
  'npg_plex_information',
  'npg_warehouse::Schema::Result::NpgPlexInformation',
  { 'foreign.study_id' => 'self.internal_id'  },
);


=head2 request

Type: has_many

Related object: L<npg_warehouse::Schema::Result::Request>

=cut

__PACKAGE__->has_many(
  'request',
  'npg_warehouse::Schema::Result::Request',
  { 'foreign.study_internal_id' => 'self.internal_id'  },
);


1;
__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

DBIx binding to the current_studies table of the warehouse database.

=head1 SUBROUTINES/METHODS

=head2 study_name returns name if it exists, else returns the id

=head2 sample_ids

=head2 request - related request objects

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Moose

=item MooseX::NonMoose

=item  MooseX::MarkAsMethods

=item DBIx::Class::Core

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


1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
