package npg_warehouse::Schema::Result::TagInstance;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

npg_warehouse::Schema::Result::TagInstance

=cut

__PACKAGE__->table("tag_instances");

=head1 ACCESSORS

=head2 dont_use_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 uuid

  data_type: 'varchar'
  is_nullable: 0
  size: 36

=head2 internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 name

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
  size: 2

=head2 two_dimensional_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 tag_uuid

  data_type: 'varchar'
  is_nullable: 1
  size: 36

=head2 tag_internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 tag_expected_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 tag_map_id

  data_type: 'integer'
  is_nullable: 1

=head2 tag_group_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 tag_group_uuid

  data_type: 'varchar'
  is_nullable: 1
  size: 36

=head2 tag_group_internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 is_current

  data_type: 'tinyint'
  is_nullable: 1

=head2 checked_at

  data_type: 'datetime'
  is_nullable: 1

=head2 last_updated

  data_type: 'datetime'
  is_nullable: 1

=head2 created

  data_type: 'datetime'
  is_nullable: 1

=head2 inserted_at

  data_type: 'datetime'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "dont_use_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "uuid",
  { data_type => "varchar", is_nullable => 0, size => 36 },
  "internal_id",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "barcode",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "barcode_prefix",
  { data_type => "varchar", is_nullable => 1, size => 2 },
  "two_dimensional_barcode",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "tag_uuid",
  { data_type => "varchar", is_nullable => 1, size => 36 },
  "tag_internal_id",
  { data_type => "integer", is_nullable => 1 },
  "tag_expected_sequence",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "tag_map_id",
  { data_type => "integer", is_nullable => 1 },
  "tag_group_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "tag_group_uuid",
  { data_type => "varchar", is_nullable => 1, size => 36 },
  "tag_group_internal_id",
  { data_type => "integer", is_nullable => 1 },
  "is_current",
  { data_type => "tinyint", is_nullable => 1 },
  "checked_at",
  { data_type => "datetime", is_nullable => 1 },
  "last_updated",
  { data_type => "datetime", is_nullable => 1 },
  "created",
  { data_type => "datetime", is_nullable => 1 },
  "inserted_at",
  { data_type => "datetime", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("dont_use_id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-04-18 10:35:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:x55nhujZ4BP11vQsvJ661g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
