
package npg_warehouse::Schema::Result::CurrentPacBioLibraryTube;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

npg_warehouse::Schema::Result::CurrentPacBioLibraryTube

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

=head1 TABLE: C<current_pac_bio_library_tubes>

=cut

__PACKAGE__->table('current_pac_bio_library_tubes');

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

=head2 barcode_prefix

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 closed

  data_type: 'tinyint'
  is_nullable: 1

=head2 state

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 two_dimensional_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 volume

  data_type: 'decimal'
  is_nullable: 1
  size: [5,2]

=head2 concentration

  data_type: 'decimal'
  is_nullable: 1
  size: [5,2]

=head2 scanned_in_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 public_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 prep_kit_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 binding_kit_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 smrt_cells_available

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 movie_length

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 protocol

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

=cut

__PACKAGE__->add_columns(
  'uuid',
  { data_type => 'binary', is_nullable => 0, size => 16 },
  'internal_id',
  { data_type => 'integer', is_nullable => 0 },
  'name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'barcode_prefix',
  { data_type => 'varchar', is_nullable => 1, size => 2 },
  'barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'closed',
  { data_type => 'tinyint', is_nullable => 1 },
  'state',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'two_dimensional_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'volume',
  { data_type => 'decimal', is_nullable => 1, size => [5, 2] },
  'concentration',
  { data_type => 'decimal', is_nullable => 1, size => [5, 2] },
  'scanned_in_date',
  { data_type => 'date', datetime_undef_if_invalid => 1, is_nullable => 1 },
  'public_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'prep_kit_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'binding_kit_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'smrt_cells_available',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'movie_length',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'protocol',
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dUaqsszpmBvVusHMv3PYhQ

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
