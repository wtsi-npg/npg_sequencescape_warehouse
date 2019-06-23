
package npg_warehouse::Schema::Result::AssetFreezer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

npg_warehouse::Schema::Result::AssetFreezer

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

=head1 TABLE: C<asset_freezers>

=cut

__PACKAGE__->table('asset_freezers');

=head1 ACCESSORS

=head2 dont_use_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 uuid

  data_type: 'binary'
  is_nullable: 0
  size: 16

=head2 internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 asset_type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 barcode_prefix

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 building

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 room

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 freezer

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 shelf

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 is_current

  data_type: 'tinyint'
  is_nullable: 1

=head2 checked_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

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

=cut

__PACKAGE__->add_columns(
  'dont_use_id',
  { data_type => 'integer', is_auto_increment => 1, is_nullable => 0 },
  'uuid',
  { data_type => 'binary', is_nullable => 0, size => 16 },
  'internal_id',
  { data_type => 'integer', is_nullable => 1 },
  'name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'asset_type',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'barcode_prefix',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'building',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'room',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'freezer',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'shelf',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'is_current',
  { data_type => 'tinyint', is_nullable => 1 },
  'checked_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
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
);

=head1 PRIMARY KEY

=over 4

=item * L</dont_use_id>

=back

=cut

__PACKAGE__->set_primary_key('dont_use_id');


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-06-11 16:30:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:F+T7hXk9teViZ1nhNX9ZjQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
