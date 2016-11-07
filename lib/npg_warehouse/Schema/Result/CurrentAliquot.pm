
package npg_warehouse::Schema::Result::CurrentAliquot;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

##no critic(RequirePodAtEnd RequirePodLinksIncludeText ProhibitMagicNumbers ProhibitEmptyQuotes)

=head1 NAME

npg_warehouse::Schema::Result::CurrentAliquot

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

=head1 TABLE: C<current_aliquots>

=cut

__PACKAGE__->table('current_aliquots');

=head1 ACCESSORS

=head2 uuid

  data_type: 'binary'
  is_nullable: 0
  size: 16

=head2 internal_id

  data_type: 'integer'
  is_nullable: 0

=head2 receptacle_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 receptacle_internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 study_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 study_internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 project_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 project_internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 library_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 library_internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 sample_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 sample_internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 tag_uuid

  data_type: 'binary'
  is_nullable: 1
  size: 16

=head2 tag_internal_id

  data_type: 'integer'
  is_nullable: 1

=head2 receptacle_type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 library_type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 insert_size_from

  data_type: 'integer'
  is_nullable: 1

=head2 insert_size_to

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

=head2 bait_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 bait_target_species

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 bait_supplier_identifier

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 bait_supplier_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  'uuid',
  { data_type => 'binary', is_nullable => 0, size => 16 },
  'internal_id',
  { data_type => 'integer', is_nullable => 0 },
  'receptacle_uuid',
  { data_type => 'binary', is_nullable => 1, size => 16 },
  'receptacle_internal_id',
  { data_type => 'integer', is_nullable => 1 },
  'study_uuid',
  { data_type => 'binary', is_nullable => 1, size => 16 },
  'study_internal_id',
  { data_type => 'integer', is_nullable => 1 },
  'project_uuid',
  { data_type => 'binary', is_nullable => 1, size => 16 },
  'project_internal_id',
  { data_type => 'integer', is_nullable => 1 },
  'library_uuid',
  { data_type => 'binary', is_nullable => 1, size => 16 },
  'library_internal_id',
  { data_type => 'integer', is_nullable => 1 },
  'sample_uuid',
  { data_type => 'binary', is_nullable => 1, size => 16 },
  'sample_internal_id',
  { data_type => 'integer', is_nullable => 1 },
  'tag_uuid',
  { data_type => 'binary', is_nullable => 1, size => 16 },
  'tag_internal_id',
  { data_type => 'integer', is_nullable => 1 },
  'receptacle_type',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'library_type',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'insert_size_from',
  { data_type => 'integer', is_nullable => 1 },
  'insert_size_to',
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
  'bait_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'bait_target_species',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'bait_supplier_identifier',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'bait_supplier_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-29 10:46:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:O7NV+JOofrVrsP3cmhBdfg

# Author:        david.jackson@sanger.ac.uk
# Maintainer:    $Author: mg8 $
# Created:       2010-04-08
# Last Modified: $Date: 2012-11-26 09:53:48 +0000 (Mon, 26 Nov 2012) $
# Id:            $Id: Run.pm 16269 2012-11-26 09:53:48Z mg8 $
# $HeadURL: svn+ssh://svn.internal.sanger.ac.uk/repos/svn/new-pipeline-dev/npg-tracking/trunk/lib/npg_tracking/Schema/Result/Run.pm $

BEGIN {
  use Moose;
  use MooseX::NonMoose;
  use MooseX::MarkAsMethods autoclean => 1;
  use Readonly; Readonly::Scalar our $VERSION => do { my ($r) = q$LastChangedRevision: 16389 $ =~ /(\d+)/mxs; $r; };
  use Carp;
  extends 'DBIx::Class::Core';
}

for my $m (qw(receptacle sample study project library)){ # alias for study_internal_id of study_id - same for project and sample
  __PACKAGE__->meta->add_method($m.q(_id), \&{$m.q(_internal_id)});
}
__PACKAGE__->meta->add_method('default_library_type', \&library_type);

=head2 sample

Type: belongs_to

Related object: L<npg_warehouse::Schema::Result::CurrentSample>

=cut

Readonly::Hash our %SAMPLE_DELEGATION => (
  (map{("sample_$_" => $_)}qw(name accession_number description reference_genome public_name common_name)),
  (map{($_ => $_)}qw(organism)),
  'organism_taxon_id' => 'taxon_id'
);
Readonly::Hash our %SAMPLE_DELEGATION_BOOL => (
  'sample_consent_withdrawn' => 'consent_withdrawn'
);
__PACKAGE__->belongs_to(
  'sample',
  'npg_warehouse::Schema::Result::CurrentSample',
  { internal_id => 'sample_internal_id' },
  {proxy => \%SAMPLE_DELEGATION}
);
while( my($local,$foreign)= each %SAMPLE_DELEGATION_BOOL ){
  __PACKAGE__->meta->add_method( $local, sub {return not shift->sample->$foreign =~/\bno|0\b/smxi} );
}


=head2 study

Type: belongs_to

Related object: L<npg_warehouse::Schema::Result::CurrentStudy>

=cut

Readonly::Hash our %STUDY_DELEGATION => (
  (map{("study_$_" => $_)}qw(name accession_number description reference_genome )),
  (map{($_ => $_)}qw(study_title)),
);
Readonly::Hash our %STUDY_DELEGATION_BOOL => (
  'study_contains_nonconsented_xahuman' => 'remove_x_and_autosomes',
  'study_contains_nonconsented_human' => 'contaminated_human_dna',
  'separate_y_chromosome_data' => 'separate_y_chromosome_data',
  'alignments_in_bam' => 'alignments_in_bam'
);
#TODO - missing: email_addresses email_addresses_of_managers email_addresses_of_followers email_addresses_of_owners alignments_in_bam 
#MAYBE - study_publishable_name
__PACKAGE__->belongs_to(
  'study',
  'npg_warehouse::Schema::Result::CurrentStudy',
  { internal_id => 'study_internal_id' },
  {proxy => \%STUDY_DELEGATION}
);
while( my($local,$foreign)= each %STUDY_DELEGATION_BOOL ){
  __PACKAGE__->meta->add_method( $local, sub {return not shift->study->$foreign =~/\bno|0\b/smxi} );
}



=head2 project

Type: belongs_to

Related object: L<npg_warehouse::Schema::Result::CurrentProject>

=cut

Readonly::Hash our %PROJECT_DELEGATION => (
  (map{("project_$_" => $_)}qw(name cost_code)),
);
__PACKAGE__->belongs_to(
  'project',
  'npg_warehouse::Schema::Result::CurrentProject',
  { internal_id => 'project_internal_id' },
  {proxy => \%PROJECT_DELEGATION}
);


=head2 tag

Type: belongs_to

Related object: L<npg_warehouse::Schema::Result::CurrentTag>

=cut

Readonly::Hash our %TAG_DELEGATION => (
  'default_tag_sequence' => 'expected_sequence',
  'tag_index' => 'map_id'
);
__PACKAGE__->belongs_to(
  'tag',
  'npg_warehouse::Schema::Result::CurrentTag',
  { internal_id => 'tag_internal_id' },
  {proxy => \%TAG_DELEGATION}
);


__PACKAGE__->meta->make_immutable;
1;

