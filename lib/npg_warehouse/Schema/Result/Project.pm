
package npg_warehouse::Schema::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

##no critic(RequirePodAtEnd RequirePodLinksIncludeText ProhibitMagicNumbers ProhibitEmptyQuotes)

=head1 NAME

npg_warehouse::Schema::Result::Project

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

=head1 TABLE: C<projects>

=cut

__PACKAGE__->table('projects');

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

=head2 collaborators

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 funding_comments

  data_type: 'text'
  is_nullable: 1

=head2 cost_code

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 funding_model

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 approved

  data_type: 'tinyint'
  is_nullable: 1

=head2 budget_division

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 external_funding_source

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 project_manager

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 budget_cost_centre

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 state

  data_type: 'varchar'
  is_nullable: 1
  size: 50

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
  'collaborators',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'funding_comments',
  { data_type => 'text', is_nullable => 1 },
  'cost_code',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'funding_model',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'approved',
  { data_type => 'tinyint', is_nullable => 1 },
  'budget_division',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'external_funding_source',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'project_manager',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'budget_cost_centre',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'state',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9N9LaKurBLvOhRouSNleDQ


__PACKAGE__->has_many(
  'npg_information',
  'npg_warehouse::Schema::Result::NpgInformation',
  { 'foreign.project_id' => 'self.internal_id'  },
);
1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
