
package npg_warehouse::Schema::Result::CurrentTag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

npg_warehouse::Schema::Result::CurrentTag

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

=head1 TABLE: C<current_tags>

=cut

__PACKAGE__->table('current_tags');

=head1 ACCESSORS

=head2 uuid

  data_type: 'binary'
  is_nullable: 0
  size: 16

=head2 internal_id

  data_type: 'integer'
  is_nullable: 0

=head2 expected_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 map_id

  data_type: 'integer'
  is_nullable: 1

=head2 tag_group_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 tag_group_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 tag_group_internal_id

  data_type: 'integer'
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
  'expected_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'map_id',
  { data_type => 'integer', is_nullable => 1 },
  'tag_group_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'tag_group_uuid',
  { data_type => 'binary', is_nullable => 1, size => 16 },
  'tag_group_internal_id',
  { data_type => 'integer', is_nullable => 1 },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:khxm4P9Dxz6EXfivx7q+1A

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
