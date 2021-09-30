
package npg_warehouse::Schema::Result::Well;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

npg_warehouse::Schema::Result::Well

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

=head1 TABLE: C<wells>

=cut

__PACKAGE__->table('wells');

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

=head2 map

  data_type: 'varchar'
  is_nullable: 1
  size: 5

=head2 plate_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 plate_barcode_prefix

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 sample_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 sample_internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 sample_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 gel_pass

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 concentration

  data_type: 'decimal'
  is_nullable: 1
  size: [10,2]

=head2 current_volume

  data_type: 'float'
  is_nullable: 1

=head2 buffer_volume

  data_type: 'float'
  is_nullable: 1

=head2 requested_volume

  data_type: 'float'
  is_nullable: 1

=head2 picked_volume

  data_type: 'float'
  is_nullable: 1

=head2 pico_pass

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

=head2 plate_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 measured_volume

  data_type: 'decimal'
  is_nullable: 1
  size: [5,2]

=head2 sequenom_count

  data_type: 'integer'
  is_nullable: 1

=head2 gender_markers

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 genotyping_status

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 genotyping_snp_plate_id

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

=head2 display_name

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  'uuid',
  { data_type => 'binary', is_nullable => 0, size => 16 },
  'internal_id',
  { data_type => 'integer', is_nullable => 0 },
  'name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'map',
  { data_type => 'varchar', is_nullable => 1, size => 5 },
  'plate_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'plate_barcode_prefix',
  { data_type => 'varchar', is_nullable => 1, size => 2 },
  'sample_uuid',
  { data_type => 'binary', is_nullable => 1, size => 16 },
  'sample_internal_id',
  { data_type => 'integer', is_nullable => 1 },
  'sample_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'gel_pass',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'concentration',
  { data_type => 'decimal', is_nullable => 1, size => [10, 2] },
  'current_volume',
  { data_type => 'float', is_nullable => 1 },
  'buffer_volume',
  { data_type => 'float', is_nullable => 1 },
  'requested_volume',
  { data_type => 'float', is_nullable => 1 },
  'picked_volume',
  { data_type => 'float', is_nullable => 1 },
  'pico_pass',
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
  'plate_uuid',
  { data_type => 'binary', is_nullable => 1, size => 16 },
  'measured_volume',
  { data_type => 'decimal', is_nullable => 1, size => [5, 2] },
  'sequenom_count',
  { data_type => 'integer', is_nullable => 1 },
  'gender_markers',
  { data_type => 'varchar', is_nullable => 1, size => 40 },
  'genotyping_status',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'genotyping_snp_plate_id',
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
  'display_name',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-06-11 16:30:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lZQSWHr5h4Wcyfq0QorUjg

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
