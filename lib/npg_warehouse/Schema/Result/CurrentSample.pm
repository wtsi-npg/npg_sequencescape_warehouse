
package npg_warehouse::Schema::Result::CurrentSample;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

npg_warehouse::Schema::Result::CurrentSample

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

=head1 TABLE: C<current_samples>

=cut

__PACKAGE__->table('current_samples');

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

=head2 organism

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 common_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 taxon_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 father

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 mother

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 replicate

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ethnicity

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 gender

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 cohort

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 country_of_origin

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 geographical_region

  data_type: 'varchar'
  is_nullable: 1
  size: 255

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

=head2 sanger_sample_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 control

  data_type: 'tinyint'
  is_nullable: 1

=head2 empty_supplier_sample_name

  data_type: 'tinyint'
  is_nullable: 1

=head2 supplier_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 public_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 sample_visibility

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 strain

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 updated_by_manifest

  data_type: 'tinyint'
  is_nullable: 1

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

=head2 consent_withdrawn

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 donor_id

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
  'organism',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'common_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'description',
  { data_type => 'text', is_nullable => 1 },
  'taxon_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'father',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'mother',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'replicate',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ethnicity',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'gender',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'cohort',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'country_of_origin',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'geographical_region',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
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
  'sanger_sample_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'control',
  { data_type => 'tinyint', is_nullable => 1 },
  'empty_supplier_sample_name',
  { data_type => 'tinyint', is_nullable => 1 },
  'supplier_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'public_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sample_visibility',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'strain',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'updated_by_manifest',
  { data_type => 'tinyint', is_nullable => 1 },
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
  'consent_withdrawn',
  { data_type => 'tinyint', default_value => 0, is_nullable => 0 },
  'donor_id',
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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-06-11 16:30:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8C3AaPwQd/JAZsZFtqiIsw

our $VERSION = '0';

=head1 SYNOPSIS

=head1 DESCRIPTION

Moose-based DBIx binding to the current_samples table of the warehouse database.

=head1 SUBROUTINES/METHODS

=head2 sample_name

Sample name or, if unavailable, sample id

=cut

sub sample_name {
    my $self = shift;
    return $self->name || $self->internal_id;
}

=head2 npg_information

Type: has_many

Related object: L<npg_warehouse::Schema::Result::NpgInformation>

=cut

__PACKAGE__->has_many(
  'npg_information',
  'npg_warehouse::Schema::Result::NpgInformation',
  { 'foreign.sample_id' => 'self.internal_id'  },
);

=head2 npg_plex_information

Type: has_many

Related object: L<npg_warehouse::Schema::Result::NpgPlexInformation>

=cut

__PACKAGE__->has_many(
  'npg_plex_information',
  'npg_warehouse::Schema::Result::NpgPlexInformation',
  { 'foreign.sample_id' => 'self.internal_id'  },
);

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Moose

=item MooseX::NonMoose

=item MooseX::MarkAsMethods

=item DBIx::Class::Core

=item Readonly

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2017 Genome Research Ltd

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
