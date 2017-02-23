#########
# Author:        David K Jackson <david.jackson@sanger.ac.uk>
# Created:       16 July 2013
use strict;
use warnings;
use Test::More tests => 38;
use Test::Exception;
use t::npg_warehouse::util;

use_ok 'npg_warehouse::Schema';
use_ok 'st::api::lims::warehouse';

my $util = t::npg_warehouse::util->new();
my $schema_wh;
my $schema_package = q[npg_warehouse::Schema];
my $fixtures_path = q[t/data/fixtures/warehouse];
lives_ok{ $schema_wh  = $util->create_test_db($schema_package, $fixtures_path) } 'wh test db created';
my@ws=('npg_warehouse_schema' => $schema_wh);

#my@ws=('npg_warehouse_schema' => npg_warehouse::Schema->connect());

#dj3@sf-3-1-04:~/repos/new-pipeline-dev/data_handling/branches/prerelease-35.0$ perl -I lib/ -le 'use npg_warehouse::Schema; my$s=npg_warehouse::Schema->connect(); print join",",$_->study_name, $_->study_id, $_->default_tag_sequence, $_->tag_index, $_->study_accession_number, $_->sample_accession_number, $_->sample_id, $_->sample_public_name, $_->sample_consent_withdrawn, $_->study_contains_nonconsented_human, $_->study_contains_nonconsented_xahuman, $_->library_type, $_->receptacle_type, "!" foreach $s->resultset("CurrentAliquot")->search({receptacle_internal_id=>7036639})'
#MeCP2: Global distribution and transcription,663,CTTGTA,12,ERP001529,ERS223727,1599118,m_5hmC_Control,,,,qPCR only,multiplexed_library_tube,!
#MeCP2: Global distribution and transcription,663,CAGATC,7,ERP001529,ERS223728,1599119,m_5hmC_Liver,,,,qPCR only,multiplexed_library_tube,!
my $lims;
dies_ok { $lims = st::api::lims::warehouse->new(@ws,) } 'do not create lims object with no attributes given';
lives_ok { $lims = st::api::lims::warehouse->new(@ws,receptacle_id => 7036639) } 'create lims object with receptacle internal id';
dies_ok { $lims = st::api::lims::warehouse->new(@ws,tube_barcode => 9999999) } 'dies if no tube with given barcode';
dies_ok { $lims = st::api::lims::warehouse->new(@ws,tube_barcode => 4137894) } 'dies if more than one tube with given barcode';
lives_ok { $lims = st::api::lims::warehouse->new(@ws,tube_barcode => 323332) } 'create lims object with tube barcode';
is($lims->position,undef,'default position(lane) is undef');
is($lims->receptacle_id,7036639,'get recpetacle (tube) id given tube barcode');
my @children=$lims->children;
is(scalar @children, 1, 'one child for this particular lims object (without position)');
($lims)=@children;
is($lims->receptacle_id,7036639,'get recpetacle (tube) id of single child');
is($lims->position,1,'position(lane) is 1');
@children=$lims->children;
is(scalar @children, 2, 'two children for this particular lims object (with position)');
($lims)=grep {$_->tag_index == 12} @children;
ok($lims, 'select plex library with tag index of 12');
is($lims->default_library_type, 'qPCR only', 'Correct library type for plexed');
is($lims->sample_accession_number, 'ERS223727', 'Correct sample accession for plexed');
is($lims->study_accession_number, 'ERP001529', 'Correct study accession for plexed');
is($lims->library_id, '7018489', 'Correct library id for plexed');

# dj3@sf-4-1-02:~/repos/new-pipeline-dev/data_handling/branches/prerelease-35.0$ perl -I lib/ -le 'use npg_warehouse::Schema; my$s=npg_warehouse::Schema->connect(); print join",",$_->study_name, $_->study_id, $_->default_tag_sequence, $_->tag_index, $_->study_accession_number, $_->sample_accession_number, $_->sample_id, $_->sample_public_name, $_->sample_consent_withdrawn, $_->study_contains_nonconsented_human, $_->study_contains_nonconsented_xahuman, $_->library_type, $_->receptacle_type, "!" foreach $s->resultset("CurrentAliquot")->search({receptacle_internal_id=>2800597})'
# SEQCAP_Genetics_of_Microcephalic_Osteodysplatics_Primordial_Dwarfism,1767,CAGATCTGAT,7,EGAS00001000064,EGAN00001006754,1136740,,1,,,Agilent Pulldown,multiplexed_library_tube,!
# SEQCAP_Genetics_of_Microcephalic_Osteodysplatics_Primordial_Dwarfism,1767,ACTTGATGAT,8,EGAS00001000064,EGAN00001006755,1136741,,,,,Agilent Pulldown,multiplexed_library_tube,!

# dj3@sf-4-1-02:~/repos/new-pipeline-dev/data_handling/branches/prerelease-35.0$ perl -I lib/ -le 'use npg_warehouse::Schema; my$s=npg_warehouse::Schema->connect(); print join",",$_->study_name, $_->study_id, $_->default_tag_sequence, $_->tag_index, $_->study_accession_number, $_->sample_accession_number, $_->sample_id, $_->sample_public_name, $_->sample_consent_withdrawn, $_->study_contains_nonconsented_human, $_->study_contains_nonconsented_xahuman, $_->library_type, $_->receptacle_type, "!" foreach $s->resultset("CurrentAliquot")->search({receptacle_internal_id=>7731009})'
# Pilot evaluation of sample collection approaches in microbiome profiling,2686,,,,,1655994,,,1,,No PCR,library_tube,!
lives_ok { $lims = st::api::lims::warehouse->new(@ws,receptacle_id => 7731009) } 'create lims object with receptacle internal id (single library tube)';
lives_ok { $lims = st::api::lims::warehouse->new(@ws,tube_ean13_barcode => 3980331130775) } 'create lims object with single library tube ean13 code';
is($lims->tube_barcode,331130,'get tube barcode given EAN13 barcode');
is($lims->receptacle_id,7731009,'get recpetacle (tube) id given tube barcode');
is($lims->position,undef,'default position(lane) is undef');
@children=$lims->children;
is(scalar @children, 1, 'one child for this particular lims object (without position)');
($lims)=@children;
is($lims->receptacle_id,7731009,'get recpetacle (tube) id of single child');
is($lims->position,1,'position(lane) is 1');
@children=$lims->children;
is(scalar @children, 0, 'no children for this particular lims object (single library tube with position)');
is($lims->default_library_type, 'No PCR', 'Correct library type for unplexed');
is($lims->sample_id, '1655994', 'Correct sample id for unplexed');
is($lims->study_id, '2686', 'Correct study id for unplexed');
is($lims->library_id, '7731009', 'Correct library id for unplexed');
ok($lims->study_contains_nonconsented_human ne 'Yes', 'nonconsented human value is not a string');
ok($lims->study_contains_nonconsented_human, 'nonconsented human is present');
is($lims->purpose,'qc','purpose');

throws_ok{ st::api::lims::warehouse->new(@ws,tube_ean13_barcode => '3980331130774') } qr/checksum fail/, 'EAN13 checksum fail'; 
throws_ok{ st::api::lims::warehouse->new(@ws,tube_ean13_barcode => '980331130774') }
  qr/EAN13 barcode checksum fail for code 980331130774/, 'expect 13 characters for EAN13';
lives_and { is st::api::lims::warehouse->new(@ws,tube_ean13_barcode => '0280331130779')->tube_barcode, '331130' } 'EAN13 barcode can start with 0';

1;
