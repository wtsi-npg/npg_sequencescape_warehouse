
package npg_warehouse::Schema::Result::NpgPlexInformation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

##no critic(RequirePodAtEnd RequirePodLinksIncludeText ProhibitMagicNumbers ProhibitEmptyQuotes)

=head1 NAME

npg_warehouse::Schema::Result::NpgPlexInformation

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

=head1 TABLE: C<npg_plex_information>

=cut

__PACKAGE__->table('npg_plex_information');

=head1 ACCESSORS

=head2 batch_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 id_run

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 position

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 tag_index

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 asset_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 asset_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 sample_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 study_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 project_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 library_type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 insert_size_quartile1

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_quartile3

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_median

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_num_modes

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_normal_fit_confidence

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [3,2]

=head2 gc_percent_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 gc_percent_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 sequence_mismatch_percent_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [4,2]

=head2 sequence_mismatch_percent_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [4,2]

=head2 adapters_percent_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 adapters_percent_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 contaminants_scan_hit1_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 contaminants_scan_hit1_score

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [6,2]

=head2 contaminants_scan_hit2_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 contaminants_scan_hit2_score

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [6,2]

=head2 ref_match1_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 ref_match1_percent

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 ref_match2_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 ref_match2_percent

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 tag_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 tag_decode_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 tag_decode_count

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q20_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q20_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q30_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q30_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q40_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q40_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 bam_num_reads

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 bam_percent_mapped

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 bam_percent_duplicate

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 bam_human_percent_mapped

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 bam_human_percent_duplicate

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 genotype_sample_name_match

  data_type: 'varchar'
  is_nullable: 1
  size: 8

=head2 genotype_sample_name_relaxed_match

  data_type: 'varchar'
  is_nullable: 1
  size: 8

=head2 genotype_mean_depth

  data_type: 'float'
  is_nullable: 1
  size: [7,2]

=head2 mean_bait_coverage

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [6,2]

=head2 on_bait_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 on_or_near_bait_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 verify_bam_id_average_depth

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [11,2]

=head2 verify_bam_id_score

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [6,5]

=head2 verify_bam_id_snp_count

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  'batch_id',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 0 },
  'id_run',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 0 },
  'position',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'tag_index',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 0 },
  'asset_id',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'asset_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sample_id',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'study_id',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'project_id',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'library_type',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'insert_size_quartile1',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_quartile3',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_median',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_num_modes',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'insert_size_normal_fit_confidence',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [3, 2],
  },
  'gc_percent_forward_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'gc_percent_reverse_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'sequence_mismatch_percent_forward_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [4, 2],
  },
  'sequence_mismatch_percent_reverse_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [4, 2],
  },
  'adapters_percent_forward_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'adapters_percent_reverse_read',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'contaminants_scan_hit1_name',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'contaminants_scan_hit1_score',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [6, 2],
  },
  'contaminants_scan_hit2_name',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'contaminants_scan_hit2_score',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [6, 2],
  },
  'ref_match1_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'ref_match1_percent',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'ref_match2_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'ref_match2_percent',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'tag_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'tag_decode_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'tag_decode_count',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q20_yield_kb_forward_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q20_yield_kb_reverse_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q30_yield_kb_forward_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q30_yield_kb_reverse_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q40_yield_kb_forward_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q40_yield_kb_reverse_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'bam_num_reads',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'bam_percent_mapped',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'bam_percent_duplicate',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'bam_human_percent_mapped',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'bam_human_percent_duplicate',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'genotype_sample_name_match',
  { data_type => 'varchar', is_nullable => 1, size => 8 },
  'genotype_sample_name_relaxed_match',
  { data_type => 'varchar', is_nullable => 1, size => 8 },
  'genotype_mean_depth',
  { data_type => 'float', is_nullable => 1, size => [7, 2] },
  'mean_bait_coverage',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [6, 2],
  },
  'on_bait_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'on_or_near_bait_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'verify_bam_id_average_depth',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [11, 2],
  },
  'verify_bam_id_score',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [6, 5],
  },
  'verify_bam_id_snp_count',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_run>

=item * L</position>

=item * L</tag_index>

=back

=cut

__PACKAGE__->set_primary_key('id_run', 'position', 'tag_index');


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-29 10:46:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Bjy11S1+7ZlvSU2rKvVQ+A


# You can replace this text with custom content, and it will be preserved on regeneration

our $VERSION = '0';

=head2 npg_info

Type: has_one

Related object: L<npg_warehouse::Schema::Result::NpgInformation>

=cut

__PACKAGE__->has_one('npg_info' => 'npg_warehouse::Schema::Result::NpgInformation',
                     {'foreign.id_run'=>'self.id_run', 'foreign.position'=>'self.position'});


with qw/ npg_qc::autoqc::role::rpt_key /;

=head2 sample

Type: belongs_to

Related object: L<npg_warehouse::Schema::Result::CurrentSample>

=cut

__PACKAGE__->belongs_to(
  'sample',
  'npg_warehouse::Schema::Result::CurrentSample',
  { internal_id => 'sample_id' },
);

=head2 study

Type: belongs_to

Related object: L<npg_warehouse::Schema::Result::CurrentStudy>

=cut

__PACKAGE__->belongs_to(
  'study',
  'npg_warehouse::Schema::Result::CurrentStudy',
  { internal_id => 'study_id' },
);


=head2 project

Type: belongs_to

Related object: L<npg_warehouse::Schema::Result::CurrentProject>

=cut

__PACKAGE__->belongs_to(
  'project',
  'npg_warehouse::Schema::Result::CurrentProject',
  { internal_id => 'project_id' },
);

=head2 sample_name

sample name or, if unavailable, sample id
  
=cut

sub sample_name {
    my $self = shift;
    return $self->sample ? $self->sample->sample_name() : $self->sample_id;
}

=head2 study_name

study name or, if unavailable, study id
  
=cut

sub study_name {
    my $self = shift;
    return $self->study ? $self->study->study_name() :  $self->study_id;
}

=head2 library_name

library name or, if unavailable, library id
  
=cut

sub library_name {
    my $self = shift;
    return $self->asset_name || $self->asset_id;
}

=head2 request

Related object: L<npg_warehouse::Schema::Result::Request>

=cut

sub request {
    my $self = shift;
    my $npg_info = $self->npg_info();
    return $npg_info ? $npg_info->request : undef;
}

1;
__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

Moose-based DBIx binding for the npg_plex_information table of the warehouse database.

=head1 SUBROUTINES/METHODS

=head2 run_lane_info - returns a relevant npg_information table row

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Moose

=item MooseX::NonMoose

=item MooseX::MarkAsMethods

=item DBIx::Class::Core

=item npg_qc::autoqc::role::rpt_key

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2017 Genome Research Ltd.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
