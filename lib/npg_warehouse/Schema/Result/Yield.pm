package npg_warehouse::Schema::Result::Yield;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

npg_warehouse::Schema::Result::Yield

=cut

__PACKAGE__->table("yield");

=head1 ACCESSORS

=head2 month

  data_type: 'bigint'
  is_nullable: 1

=head2 division

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 id_run

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 instrument_model

  data_type: 'char'
  is_nullable: 1
  size: 64

=head2 cycles

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 kind

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 samples

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 yield

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "month",
  { data_type => "bigint", is_nullable => 1 },
  "division",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "id_run",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "instrument_model",
  { data_type => "char", is_nullable => 1, size => 64 },
  "cycles",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "kind",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "samples",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "yield",
  { data_type => "double precision", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-08-18 14:17:34
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2ZowOSaS5ZYq/8XlnLO6jQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
