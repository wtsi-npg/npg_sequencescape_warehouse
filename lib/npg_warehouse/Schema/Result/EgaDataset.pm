
package npg_warehouse::Schema::Result::EgaDataset;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

##no critic(RequirePodAtEnd RequirePodLinksIncludeText ProhibitMagicNumbers ProhibitEmptyQuotes)

=head1 NAME

npg_warehouse::Schema::Result::EgaDataset

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

=head1 TABLE: C<ega_datasets>

=cut

__PACKAGE__->table('ega_datasets');

=head1 ACCESSORS

=head2 ebi_study_acc

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=head2 dataset_acc

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=head2 study_id

  data_type: 'integer'
  is_nullable: 1

=head2 timestamp

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  'ebi_study_acc',
  { data_type => 'varchar', is_nullable => 1, size => 15 },
  'dataset_acc',
  { data_type => 'varchar', is_nullable => 1, size => 15 },
  'study_id',
  { data_type => 'integer', is_nullable => 1 },
  'timestamp',
  {
    data_type => 'timestamp',
    datetime_undef_if_invalid => 1,
    default_value => \'current_timestamp',
    is_nullable => 0,
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-29 10:46:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:D7+29HFknRlKa9OigpHQKA


# You can replace this text with custom content, and it will be preserved on regeneration
1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
