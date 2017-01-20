
package npg_warehouse::Schema::Result::NpgInformation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

##no critic(RequirePodAtEnd RequirePodLinksIncludeText ProhibitMagicNumbers ProhibitEmptyQuotes)

=head1 NAME

npg_warehouse::Schema::Result::NpgInformation

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

=head1 TABLE: C<npg_information>

=cut

__PACKAGE__->table('npg_information');

=head1 ACCESSORS

=head2 id_npg_information

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

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

=head2 id_run_pair

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 run_complete

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 cycles

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 cluster_count

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 pf_bases

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 is_dev

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 has_two_runfolders

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 paired_read

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 cancelled

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 instrument_name

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 instrument_model

  data_type: 'char'
  is_nullable: 1
  size: 64

=head2 manual_qc

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 clusters_raw

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 raw_cluster_density

  data_type: 'double precision'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [12,3]

=head2 pf_cluster_density

  data_type: 'double precision'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [12,3]

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

=head2 run_pending

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 qc_complete

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 tags_decode_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 tags_decode_cv

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [6,2]

=head2 asset_id

  data_type: 'integer'
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

=head2 request_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 lane_type

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 spike_tag_index

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 library_type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 q20_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q20_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q30_yield_kb_forward_read

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q30_yield_kb_reverse_read

  data_type: 'bigint'
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

=head2 split_human_percent

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 split_phix_percent

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

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
  'id_npg_information',
  {
    data_type => 'bigint',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'batch_id',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 0 },
  'id_run',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 0 },
  'position',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'id_run_pair',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'run_complete',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'cycles',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'cluster_count',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'pf_bases',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'is_dev',
  {
    data_type => 'tinyint',
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  'has_two_runfolders',
  {
    data_type => 'tinyint',
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  'paired_read',
  {
    data_type => 'tinyint',
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  'cancelled',
  {
    data_type => 'tinyint',
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  'instrument_name',
  { data_type => 'char', is_nullable => 1, size => 32 },
  'instrument_model',
  { data_type => 'char', is_nullable => 1, size => 64 },
  'manual_qc',
  { data_type => 'tinyint', extra => { unsigned => 1 }, is_nullable => 1 },
  'clusters_raw',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'raw_cluster_density',
  {
    data_type => 'double precision',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [12, 3],
  },
  'pf_cluster_density',
  {
    data_type => 'double precision',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [12, 3],
  },
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
  'run_pending',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'qc_complete',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'tags_decode_percent',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  'tags_decode_cv',
  {
    data_type => 'float',
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [6, 2],
  },
  'asset_id',
  { data_type => 'integer', is_nullable => 1 },
  'asset_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sample_id',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'study_id',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'project_id',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'request_id',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'lane_type',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'spike_tag_index',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'library_type',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'q20_yield_kb_forward_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q20_yield_kb_reverse_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q30_yield_kb_forward_read',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'q30_yield_kb_reverse_read',
  { data_type => 'bigint', extra => { unsigned => 1 }, is_nullable => 1 },
  'q40_yield_kb_forward_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'q40_yield_kb_reverse_read',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'split_human_percent',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
  'split_phix_percent',
  { data_type => 'float', is_nullable => 1, size => [5, 2] },
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

=item * L</id_npg_information>

=back

=cut

__PACKAGE__->set_primary_key('id_npg_information');

=head1 UNIQUE CONSTRAINTS

=head2 C<batch_run_pos>

=over 4

=item * L</batch_id>

=item * L</id_run>

=item * L</position>

=back

=cut

__PACKAGE__->add_unique_constraint('batch_run_pos', ['batch_id', 'id_run', 'position']);

=head2 C<id_run_position>

=over 4

=item * L</id_run>

=item * L</position>

=back

=cut

__PACKAGE__->add_unique_constraint('id_run_position', ['id_run', 'position']);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-29 10:46:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Mf0q8WzyybqXtsFLlBNagQ

# The text below will be preserved on regeneration

our $VERSION = '0';

with qw/ npg_qc::autoqc::role::rpt_key /;

=head2 npg_plex_information

Related object: L<npg_warehouse::Schema::Result::NpgPlexInformation>

=cut

__PACKAGE__->has_many(
  'npg_plex_information',
  'npg_warehouse::Schema::Result::NpgPlexInformation',
  { 'foreign.id_run' => 'self.id_run', 'foreign.position' => 'self.position', },
);


=head2 run_statuses

Related object: L<npg_warehouse::Schema::Result::NpgRunStatus>

=cut

__PACKAGE__->has_many(
  'run_statuses',
  'npg_warehouse::Schema::Result::NpgRunStatus',
  { 'foreign.id_run' => 'self.id_run' },
  { order_by => { '-desc' => 'me.iscurrent'},
    prefetch => 'id_run_status_dict',
  },
);

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

=head2 request

Type: belongs_to

Related object: L<npg_warehouse::Schema::Result::CurrentRequest>

=cut

__PACKAGE__->belongs_to(
  'request',
  'npg_warehouse::Schema::Result::CurrentRequest',
  { internal_id => 'request_id' },
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
  return $self->study ? $self->study->study_name() : $self->study_id;
}

=head2 library_name

library name or, if unavailable, library id
  
=cut

sub library_name {
  my $self = shift;
  return $self->asset_name || $self->asset_id;
}

=head2 current_run_status
  
=cut

sub current_run_status {
  my ( $self ) = @_;
  my $crs;
  foreach my $rs ( $self->run_statuses() ) {
    if ( $rs->iscurrent() ) {
      $crs = $rs;
      last;
    }
  }
  return $crs->id_run_status_dict->description();
}

1;
__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

Moose-based DBIx binding for the npg_information table of the warehouse database.

=head1 SUBROUTINES/METHODS

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Moose

=item MooseX::NonMoose

=item DBIx::Class::Core

=item MooseX::MarkAsMethods

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
