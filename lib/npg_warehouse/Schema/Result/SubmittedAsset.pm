use utf8;
package npg_warehouse::Schema::Result::SubmittedAsset;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

npg_warehouse::Schema::Result::SubmittedAsset

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

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<submitted_assets>

=cut

__PACKAGE__->table("submitted_assets");

=head1 ACCESSORS

=head2 dont_use_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 order_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 asset_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 deleted_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "dont_use_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "order_uuid",
  { data_type => "binary", is_nullable => 1, size => 16 },
  "asset_uuid",
  { data_type => "binary", is_nullable => 1, size => 16 },
  "deleted_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</dont_use_id>

=back

=cut

__PACKAGE__->set_primary_key("dont_use_id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-07-26 21:01:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1IAnnEo8Z5X3pS6MZGJsFQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
