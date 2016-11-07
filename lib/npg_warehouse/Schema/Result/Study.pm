
package npg_warehouse::Schema::Result::Study;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

##no critic(RequirePodAtEnd RequirePodLinksIncludeText ProhibitMagicNumbers ProhibitEmptyQuotes)

=head1 NAME

npg_warehouse::Schema::Result::Study

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

=head1 TABLE: C<studies>

=cut

__PACKAGE__->table('studies');

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

=head2 C<uuid_and_current_from_and_current_to_idx>

=over 4

=item * L</uuid>

=item * L</current_from>

=item * L</current_to>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'uuid_and_current_from_and_current_to_idx',
  ['uuid', 'current_from', 'current_to'],
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-29 10:46:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:l8LgnydN/6B8Dl5lw+qfJQ


# You can replace this text with custom content, and it will be preserved on regeneration

#########
# Author:        Marina Gourtovaia
# Maintainer:    $Author$
# Created:       4 April 2011
# Last Modified: $Date$
# Id:            $Id$
# $HeadURL$

use Carp;

__PACKAGE__->has_many(
  'npg_information',
  'npg_warehouse::Schema::Result::NpgInformation',
  { 'foreign.study_id' => 'self.internal_id'  },
);

foreach my $col (qw(contains_human_dna contaminated_human_dna)) {
  my $datatype  = __PACKAGE__->column_info($col)->{'data_type'} or croak "cannot determine datatype for column '$col'";
  if ('varchar' eq $datatype){
    __PACKAGE__->inflate_column( $col, {
       inflate => sub {
         my $data = shift;
         my $result;
         if (defined $data) {
           $result = $data !~ m{No|0}simx;
         }
         return $result;
       },
       deflate => sub {
         my $data = shift;
         $data ? 'Yes' : 'No';
       },
    });
  }else{
    carp "Column $col has had its dataype changed from varchar to $datatype: inflator and deflator can be removed";
  }
}

__PACKAGE__->meta->make_immutable;

1;
__END__

=head1 NAME

npg_warehouse::Schema::Result::Study

=head1 VERSION

$LastChangedRevision$

=head1 SYNOPSIS

=head1 DESCRIPTION

DBIx binding to the studies table of the warehouse database.

=head1 SUBROUTINES/METHODS

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item DBIx::Class::Core

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2011 GRL, Marina Gourtovaia

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
