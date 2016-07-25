package npg_warehouse::Schema::Result::PulldownMultiplexedLibraryTube;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

npg_warehouse::Schema::Result::PulldownMultiplexedLibraryTube

=cut

__PACKAGE__->table("pulldown_multiplexed_library_tubes");

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

=head2 state

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 closed

  data_type: 'tinyint'
  is_nullable: 1

=head2 concentration

  data_type: 'decimal'
  is_nullable: 1
  size: [5,2]

=head2 volume

  data_type: 'decimal'
  is_nullable: 1
  size: [5,2]

=head2 two_dimensional_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 scanned_in_date

  data_type: 'date'
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

=head2 public_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

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
  "state",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "closed",
  { data_type => "tinyint", is_nullable => 1 },
  "concentration",
  { data_type => "decimal", is_nullable => 1, size => [5, 2] },
  "volume",
  { data_type => "decimal", is_nullable => 1, size => [5, 2] },
  "two_dimensional_barcode",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "scanned_in_date",
  { data_type => "date", is_nullable => 1 },
  "is_current",
  { data_type => "tinyint", is_nullable => 1 },
  "checked_at",
  { data_type => "datetime", is_nullable => 1 },
  "last_updated",
  { data_type => "datetime", is_nullable => 1 },
  "created",
  { data_type => "datetime", is_nullable => 1 },
  "public_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "inserted_at",
  { data_type => "datetime", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("dont_use_id");


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-08-18 14:17:34
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HlKvFrrSPDFGt8a5qE7cbg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
