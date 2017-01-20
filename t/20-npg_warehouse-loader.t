use strict;
use warnings;
use Test::More tests => 203;
use Test::Exception;
use Test::Deep;
use DateTime;

# Reset HOME to retrieve test npg_tracking configuratio file from ${HOME}/.npg
local $ENV{'HOME'};
BEGIN{ $ENV{'HOME'}='t/data';}

use npg_qc::autoqc::qc_store;
use t::npg_warehouse::util;
use npg_warehouse::loader::autoqc;

local $ENV{NPG_WEBSERVICE_CACHE_DIR} = q[t/data/npg_warehouse_loader];

BEGIN { use_ok('npg_warehouse::loader'); }

################################################################
#         Test cases description
################################################################
#batch_id # id_run # paired_id_run # paired_read # wh # npg # qc
################################################################
#2044     #  1272   # 1246          # 1           # 1  #  1  # 1
#4354     #  3500   # 3529          # 1           # 1  #  1  # 1
#4178     #  3323   # 3351          # 1           # 1  #  1  # 1
#4445     #  3622   #               # 0           # 1  #  1  # 1
#4915     #  3965   #               # 1           # 1  #  1  # 1
#4965     #  4025   #               # 1           # 1  #  1  # 1
#4380     #  3519   #               #             #    #  1  #
#5169     #  4138   #               #             #    #  1  #  this run is cancelled without qc complete status
#5498     #  4333   #               # 1           #    #  1  # 1 tag decoding stats added
#6669     #  4779   # 
#12509    #  6624   #               # 1           #    #     # 1 split and bam stats added; tag metrics and tag decode added; pulldown metrics added
#12498    #  6642   #               # 1           #    #     # 1 split and bam stats added
################################################################

my $util = t::npg_warehouse::util->new();
my $schema_wh;
my $schema_npg;
my $schema_qc;
my $autoqc_store =  npg_qc::autoqc::qc_store->new(use_db => 0, verbose => 0);
my $loader;
my $lane_table = q[NpgInformation];
my $plex_table = q[NpgPlexInformation];
my $plex_key = q[plexes];

{
  my $schema_package = q[npg_warehouse::Schema];
  my $fixtures_path = q[t/data/fixtures/warehouse];
  lives_ok{ $schema_wh  = $util->create_test_db($schema_package, $fixtures_path) } 'wh test db created';

  my $transaction = sub {
    my $rs_in = $schema_wh->resultset('NpgInformation');
    $rs_in->update_or_create({batch_id => 4915, id_run => 3965, position => 1, paired_read => 0,});
    $rs_in->update_or_create({batch_id => 4178, id_run => 3351, position => 1, id_run_pair => 0,});
                          };
  lives_ok {$schema_wh->txn_do($transaction);} 'changes ok in the warehouse test database';
  
  $schema_package = q[npg_qc::Schema];
  $fixtures_path = q[t/data/fixtures/npgqc];
  lives_ok{ $schema_qc  = $util->create_test_db($schema_package, $fixtures_path) } 'qc test db created';

  $schema_package = q[npg_tracking::Schema];
  $fixtures_path = q[t/data/fixtures/npg];
  lives_ok{ $schema_npg = $util->create_test_db($schema_package, $fixtures_path) } 'npg test db created';

  # for some runs, set the date of qc complete status within the last month
  # for one run create an extra status line

  my $dt = DateTime->now(time_zone => 'floating');
  $dt->subtract(days => 4);

  $transaction = sub {
    my $rs_in = $schema_npg->resultset('RunStatus');
    $rs_in->update_or_create({id_run_status => 55660, date => $dt,}); #run 4025
    $rs_in->update_or_create({id_run_status => 54689, date => $dt,}); #run 3965
    $rs_in->update_or_create({id_run_status => 64464, date => $dt,}); #run 4799
                     };
  lives_ok {$schema_npg->txn_do($transaction);} 'date changes ok in the npg test database';
}


{
  lives_ok {
       $loader  = npg_warehouse::loader->new( 
                                              _autoqc_store => $autoqc_store,
                                              _schema_npg   => $schema_npg, 
                                              _schema_qc    => $schema_qc, 
                                              _schema_wh    => $schema_wh,
                                              recent        => 0,
                                              _faster_globs => 0,
                                             )
  } 'loader object instantiated by passing schema objects to the constructor';
  isa_ok ($loader, 'npg_warehouse::loader');
}

{
  diag 'LOADING THE DATA...';
  lives_ok {$loader->load} 'load does not throw an error';
}

{
  my $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 1272,},
  );
  is ($rs->count, 8,'8 rows for run 1246');

  $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 1246,},
  );
  is ($rs->count, 8,'8 rows for run 1272');

  my $r  = $rs->next;
  is ($r->position, 1, 'position from a result set for position 1');
  is ($r->qc_complete->datetime, '2008-09-25T13:18:20', 'latest qc complete date for position 1');
  is ($r->run_pending->datetime, '2008-08-19T09:55:12', 'run pending for position 1');
  is ($r->qc_complete->datetime, '2008-09-25T13:18:20', 'run complete for position 1');
  is ($r->asset_id, '50313', 'asset id for position 1');
  is ($r->asset_name, 'PD3682a 1', 'asset name for position 1');
  is ($r->sample_id, '1322', 'sample id for position 1');
  is ($r->request_id, '44583', 'request id for position 1');
  is ($r->lane_type, 'library', 'lane type for position 1');
  is ($r->library_type, 'High complexity and double size selected', 'library type for position 1');

  $r = $rs->next;
  is ($r->position, 2, 'result set for position 2');
  is ($r->run_pending->datetime, '2008-08-19T09:55:12', 'run pending for position 2');
  is ($r->qc_complete->datetime, '2008-09-25T13:18:20', 'run complete for position 2');
  is ($r->asset_id, '50313', 'asset id for position 2');
  is ($r->asset_name, 'PD3682a 1', 'asset name for position 2');
  is ($r->sample_id, 1322, 'sample id for position 2');
  is ($r->request_id, '44584', 'request id for position 2');
  is ($r->lane_type, 'library', 'lane type for position 1');
  is ($r->library_type, 'High complexity and double size selected', 'library type for position 2');
}

{
  my $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 4138,},
  );
  is ($rs->count, 8,'8 rows for run 4138');
  while (my $row = $rs->next) {
    is($row->manual_qc, undef, 'data discarded run - manual qc undef');
  }
}


{
  my $r = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 3622, position => 1,},
  )->next;
  is ($r->run_pending->datetime, '2009-08-27T11:58:15', 'run pending date');
  is ($r->qc_complete->datetime, '2009-09-10T16:15:08', 'qc complete date');  
}


{
  # paired single folder run
  my $r = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 3965, position => 1,},
  )->next;
  is ($r->has_two_runfolders, 0, 'run has one runfolder');
  is ($r->clusters_raw, 185608, 'clusters_raw as expected');
  is ($r->pf_bases, 1430265+1430265 , 'pf_bases is summed up for two ends for a paired single folder run');
}


{
  my $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 3519,},
  );
  is($rs->count, 8, '8 rows created in the npg_information table');
  is($rs->next->batch_id, 4380, 'batch_id created ok');
  
  $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 3965, position => 1, },
  );
  is($rs->next->paired_read, 1, 'paired read flag updated correctly');

  $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 3351, position => 1, },
  );
  my $row = $rs->next;
  is($row->id_run_pair, 3323, 'paired id_run updated correctly');
  is($row->raw_cluster_density, undef, 'raw_cluster_density undefined');
  is($row->pf_cluster_density, undef, 'pf_cluster_density undefined');
}


{
  my $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 4333,},
  );

  my $values = {
          1 => {'raw_cluster_density' => 95465.880,  'pf_cluster_density' => 11496.220, 'q30_yield_kb_reverse_read' => '105906', 'q30_yield_kb_forward_read' => '98073', 'q40_yield_kb_forward_read' => '0'},
          2 => {'raw_cluster_density' => 325143.800, 'pf_cluster_density' => 82325.490, 'q30_yield_kb_reverse_read' => '1003112','q30_yield_kb_forward_read' => '563558'},
          3 => {'raw_cluster_density' => 335626.700, 'pf_cluster_density' => 171361.900,'q30_yield_kb_reverse_read' => '1011728','q30_yield_kb_forward_read' => '981688'},
          4 => {'raw_cluster_density' => 175608.400, 'pf_cluster_density' => 161077.600,'q30_yield_kb_reverse_read' => '714510', 'q30_yield_kb_forward_read' => '745267', 'q40_yield_kb_forward_read' => '56', 'q40_yield_kb_reverse_read' => '37','insert_size_quartile1' => 172, 'insert_size_quartile3' => 207, 'insert_size_median' => 189, 'insert_size_num_modes' => 1, 'insert_size_normal_fit_confidence' => 0.35,},
          5 => {'raw_cluster_density' => 443386.900, 'pf_cluster_density' => 380473.100,'q30_yield_kb_reverse_read' => '1523282','q30_yield_kb_forward_read' => '1670331'},
          6 => {'raw_cluster_density' => 454826.200, 'pf_cluster_density' => 397424.100,'q30_yield_kb_reverse_read' => '1530965','q30_yield_kb_forward_read' => '1689674'},
          7 => {'raw_cluster_density' => 611192.000, 'pf_cluster_density' => 465809.300,'q30_yield_kb_reverse_read' => '997068', 'q30_yield_kb_forward_read' => '1668517'},
          8 => {'raw_cluster_density' => 511924.700, 'pf_cluster_density' => 377133.300, 'q30_yield_kb_forward_read' => '1111015'},
               };

  is ($rs->count, 8, '8 rows loaded for run 4333');

  my $row;
  my @usual_fields = qw/raw_cluster_density pf_cluster_density q30_yield_kb_forward_read q30_yield_kb_reverse_read /;
  my @is_fields = qw/insert_size_quartile1 insert_size_quartile3 insert_size_median insert_size_num_modes insert_size_normal_fit_confidence/;
  while ($row = $rs->next) {
    my $position = $row->position;
    my @fields = @usual_fields;
    if ($position == 4) {
      push @fields, @is_fields;
    }
    foreach my $column (@fields) {
      is($row->$column, $values->{$position}->{$column}, qq[$column value for run 4333 position $position]);
    }
  }
}


{
  my @positions = qw/ 1 4 7 /;
  my @runs = qw/ 4025 4799 /;
  my @plex_fields = qw/ asset_id asset_name sample_id study_id project_id library_type/;
  my @fields = @plex_fields;
  push @fields, qw/request_id lane_type is_dev /;
  my $date = DateTime->now(time_zone => 'floating');

  my $expected = {
  4025=>{
  1 => {asset_id=>'59157',asset_name=>'B1267_Exp4 1',sample_id=>'9272', request_id=>'2913038', lane_type=>'library', is_dev => 0, study_id => 377, project_id => 377, library_type=>"qPCR only",},
  4 => {asset_id=>'79577',asset_name=>'phiX CT1462-2 1',sample_id=>'9836', request_id=>'43885', lane_type=>'control', is_dev => 0, study_id => undef, project_id => undef, library_type=>undef,},
  7 => {asset_id=>'59259',asset_name=>'NA18563pd2a 1',sample_id=>'9388', request_id=>'39455', lane_type=>'library', is_dev => 1, study_id => 188, project_id => 188, library_type=>"qPCR only",},
        },
  4799=>{
  1 => {asset_id=>'236583',asset_name=>'O157_Input 236583',sample_id=>'112662', request_id=>'550377', lane_type=>'library', is_dev => 1, study_id => 576, project_id => 576, library_type=>"Custom",},
  4 => {asset_id=>'79572',asset_name=>'phiX_SI_SPRI 1',sample_id=>'9831', request_id=>'550403', lane_type=>'control', is_dev => 0, study_id => undef, project_id => undef, library_type=>undef,},
  7 => {asset_id=>'236519',asset_name=>'26May2010', sample_id => undef,request_id=>'550401', lane_type=>'pool', is_dev => 1, study_id => 590, project_id => 46, library_type=>"Custom",},
       } 
  };

  my $plexes = {
  1 => {asset_id=>'236515',asset_name=>'U266 236515', sample_id=>'112635', study_id=>590, project_id=>46, library_type=>"Custom",},
  2 => {asset_id=>'236516',asset_name=>'10E-4NPM1_U266 236516', sample_id=>'112636', study_id=>590, project_id=>46, library_type=>"Custom",},
  3 => {asset_id=>'236517',asset_name=>'10E-3NPM1_U266 236517', sample_id=>'112637', study_id=>590, project_id=>46, library_type=>"Custom",},
  4 => {asset_id=>'236518',asset_name=>'10E-2NPM1_U266 236518', sample_id=>'112638', study_id=>590, project_id=>46, library_type=>"Custom",},
               };
  my $results = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => \@runs, position => \@positions,},
  );

  my $loaded = {};
  while (my $rs = $results->next) {
    foreach my $field (@fields) {
      $loaded->{$rs->id_run}->{$rs->position}->{$field} = $rs->$field;
    }
  }
  cmp_deeply($loaded, $expected, 'run meta info loaded for runs 4025 and 4799');

  $results = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, tag_index => [1,2,3,4]},
  );
  is ($results->count, 20, '20 rows in the plex table for run 4799');

  my $expected_tag_info =  {
    1 => {tag_decode_percent=>12.99, tag_sequence=>'ATCACGT',},
    2 => {tag_decode_percent=>12.80, tag_sequence=>'CGATGTT',},
    3 => {tag_decode_percent=>4.78, tag_sequence=>'TTAGGCA',},
    4 => {tag_decode_percent=>10.12, tag_sequence=>'TGACCAC',},
  };
 
  $loaded = {};
  my $tag_info = {};
  while (my $rs = $results->next) {
    if ($rs->position == 7) {
      my $index = $rs->tag_index;
      foreach my $field (@plex_fields) {
        $loaded->{$index}->{$field} = $rs->$field;
      }
      $tag_info->{$index}->{tag_decode_percent} = $rs->tag_decode_percent;
      $tag_info->{$index}->{tag_sequence} = $rs->tag_sequence;
    }
  }

  cmp_deeply($loaded, $plexes, 'run meta info loaded for runs 4799 position 7 plexex 1-4');
  cmp_deeply($tag_info, $expected_tag_info, 'tag info loaded for runs 4799 position 7 plexex 1-4');

  my $result = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, position=>7,tag_index => 5},
  )->first;
  ok($result, 'a row for  a tag index that is not listed in batch exists - a mock for tag_index=0');
  is($result->asset_id, undef, 'asset id not defined for a tag index that is not listed in batch');
}

{
  my $id_run = 4333;
  my @positions = qw/1 4 8/;
  my $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => $id_run, position => \@positions},
  );

  is ($rs->count, 3, 'correct number of rows with autoqc results in the db');

  my @columns =               qw (
     insert_size_quartile1 
     insert_size_quartile3 
     insert_size_median
     gc_percent_forward_read 
     gc_percent_reverse_read
     sequence_mismatch_percent_forward_read 
     sequence_mismatch_percent_reverse_read
     adapters_percent_forward_read 
     adapters_percent_reverse_read
     contaminants_scan_hit1_name
     contaminants_scan_hit1_score
     contaminants_scan_hit2_name
     contaminants_scan_hit2_score
     tags_decode_percent
     tags_decode_cv
                                   );

  my $expected = {};
  foreach my $position (@positions) {
    foreach my $column (@columns) {
      $expected->{$id_run}->{$position}->{$column} = undef;
    }
  }

  $expected->{4333}->{4}->{insert_size_quartile1} = 172;
  $expected->{4333}->{4}->{insert_size_quartile3} = 207;
  $expected->{4333}->{4}->{insert_size_median}    = 189;
  $expected->{4333}->{4}->{gc_percent_forward_read} = 44.89;
  $expected->{4333}->{4}->{gc_percent_reverse_read} = 44.88;
  $expected->{4333}->{4}->{sequence_mismatch_percent_forward_read} = 0.31;
  $expected->{4333}->{4}->{sequence_mismatch_percent_reverse_read} = 0.50;
  $expected->{4333}->{4}->{adapters_percent_forward_read} = 0.03;
  $expected->{4333}->{4}->{adapters_percent_reverse_read} = 0.02;
  $expected->{4333}->{4}->{contaminants_scan_hit1_name}  = q[PhiX];
  $expected->{4333}->{4}->{contaminants_scan_hit1_score} = 97.30;
  $expected->{4333}->{4}->{contaminants_scan_hit2_name}  = q[Mus_musculus];
  $expected->{4333}->{4}->{contaminants_scan_hit2_score} = 0.12;
  $expected->{4333}->{4}->{tags_decode_percent} = undef;
  $expected->{4333}->{4}->{tags_decode_cv} = undef;

  $expected->{4333}->{1}->{gc_percent_forward_read} = 45.29;
  $expected->{4333}->{1}->{gc_percent_reverse_read} = 45.18;
  $expected->{4333}->{1}->{adapters_percent_forward_read} = 31.99;
  $expected->{4333}->{1}->{adapters_percent_reverse_read} = 25.93;
  $expected->{4333}->{1}->{contaminants_scan_hit1_name}  = q[Mus_musculus];
  $expected->{4333}->{1}->{contaminants_scan_hit1_score} = 16.03;
  $expected->{4333}->{1}->{contaminants_scan_hit2_name}  = q[Homo_sapiens];
  $expected->{4333}->{1}->{contaminants_scan_hit2_score} = 6.96;
  $expected->{4333}->{1}->{tags_decode_percent} = 99.29;
  $expected->{4333}->{1}->{tags_decode_cv} = 55.1;

  $expected->{4333}->{8}->{insert_size_quartile3} = 207;
  $expected->{4333}->{8}->{insert_size_median}    = 189;
  $expected->{4333}->{8}->{tags_decode_percent} =81.94;
  $expected->{4333}->{8}->{tags_decode_cv} =122.4;
  #the third quartile has been skipped - the value is too large
 
  my $autoqc = {};
  while (my $row = $rs->next) {
    foreach my $column (@columns) {
      $autoqc->{4333}->{$row->position}->{$column} = $row->$column;
    }
  }
  cmp_deeply($autoqc, $expected, 'loaded autoqc results');
}


{
  my $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 3965, position => 2,},
  )->next;
  is ($rs->tags_decode_percent, undef, 'tags_decode_percent NULL where not loaded');

  my $rs_count = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4025},
  )->count;
  is ($rs_count, 0, 'no rows in the plex table for a non-multiplex run');

  $rs_count = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4333},
  )->count;
  is ($rs_count, 67, '67 rows in the plex table for a run with tag-decoding stats');

  $rs = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, position => 3},
  );
  is ($rs->count, 9, '9 rows in the plex table for a run-lane with tag-decoding stats and autoqc for plexes');

  # How many valid tags
  $rs = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, position => 3, tag_index=>1},
  )->next;
  is($rs->tag_decode_percent, 11.4, 'tag decode percent for tag 1');
  is($rs->asset_name, 'U266 236515', 'asset_name for tag 1');
  is($rs->asset_id, 236515, 'asset_id for tag 1');
  is($rs->sample_id, 112635, 'sample_id for tag 1');

  $rs = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, position => 3, tag_index=>4},
  )->next;
  is($rs->insert_size_quartile1, undef, 'quartile undefined for tag 4');

  $rs = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, position => 3, tag_index=>12},
  );
  is ($rs->count, 0, 'nothing for tag 12');

  $rs = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, position => 3, tag_index=>0},
  )->next;
  is($rs->tag_decode_percent, undef, 'tag decode percent undefined for tag 0');
  is($rs->insert_size_quartile3, 207, 'quartile3 correct for tag 0');

  $rs = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, position => 3, tag_index=>2},
  )->next;
  is($rs->insert_size_median, 189, 'median correct for tag 2');
}


{
  my $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 4799, position => 1,},
  )->next;
  is ($rs->q20_yield_kb_forward_read, 46671, 'qx forward lane 1');
  is ($rs->q20_yield_kb_reverse_read, 39877, 'qx reverse lane 1');

  is ($rs->ref_match1_name,  q[Homo sapiens 1000Genomes], 'ref_match name1 lane 1');
  is ($rs->ref_match1_percent, 95.7, 'ref_match count1 lane 1');
  is ($rs->ref_match2_name,  q[Gorilla gorilla gorilla], 'ref_match name2 lane 1');
  is ($rs->ref_match2_percent, 85.2, 'ref_match count2 lane 1');

  $rs = $loader->_schema_wh->resultset('NpgInformation')->search(
       {id_run => 4799, position => 4,},
  )->next;
  is ($rs->ref_match1_name,  q[Homo sapiens 1000Genomes], 'ref_match name1 lane 4');
  is ($rs->ref_match1_percent, 97.2, 'ref_match count1 lane 4');
  is ($rs->ref_match2_name,  q[Gorilla gorilla gorilla], 'ref_match name2 lane 4');
  is ($rs->ref_match2_percent, 87.2, 'ref_match count2 lane 4');

  $rs = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, position => 3, tag_index => 0,},
  )->next;
  is ($rs->q20_yield_kb_forward_read, 46671, 'qx forward lane 3, tag 0');
  is ($rs->q20_yield_kb_reverse_read, 39877, 'qx reverse lane 3, tag 0');

  $rs = $loader->_schema_wh->resultset('NpgPlexInformation')->search(
       {id_run => 4799, position => 3, tag_index => 3,},
  )->next;
  is ($rs->q20_yield_kb_forward_read, 1455655, 'qx forward lane 3, tag 3');
  is ($rs->q20_yield_kb_reverse_read, 1393269, 'qx reverse lane 3, tag 3');
}

{
  my $loader1   = npg_warehouse::loader->new( 
                                              _autoqc_store => $autoqc_store,
                                              _schema_npg   => $schema_npg, 
                                              _schema_qc    => $schema_qc, 
                                              _schema_wh    => $schema_wh,
                                              recent        => 1,
                                              with_lims     => 0,
                                              _faster_globs => 0,
                                            );
  is($loader1->recent, 1, 'recent is 1 as set');

  my $rs = $loader1->_schema_wh->resultset('NpgInformation');
  $rs->update_or_create({id_run => 3965, position => 2, asset_name => undef,});

  diag 'LOADING THE DATA...';
  $loader1->load;
  my $r = $rs->search({id_run => 3965, position => 2,},)->next;
  
  ok($r, 'result set exists for run 3965 position 2');
  ok(!$r->asset_name, 'asset name is not defined');

  is($r->instrument_name, q[IL36] , 'instr name');
  is($r->instrument_model, q[HK] , 'instr model');

  $r = $rs->find({id_run => 3965, position => 3,},);
  ok($r, 'result set exists for run 3965 position 3');
  is($r->instrument_name, q[IL36] , 'instr name');
  is($r->instrument_model, q[HK] , 'instr model');
}

{
  lives_ok { $schema_wh->resultset('NpgInformation')->delete_all } 'all rows deleted from the warehouse';
  is (scalar $schema_wh->resultset('NpgInformation')->search->all, 0, 'zero rows are now in the warehouse');
  
  my $loader1;
  lives_ok { $loader1 = npg_warehouse::loader->new(
                                              _autoqc_store => $autoqc_store,
                                              _schema_npg   => $schema_npg, 
                                              _schema_qc    => $schema_qc, 
                                              _schema_wh    => $schema_wh,
                                              recent        => 1,
                                              with_lims     => 0,
                                              id_run        => [4799],
                                              _faster_globs => 0,
                                                 ) } 'loader object is created with id_run and recent attrs set';
  is($loader1->recent, 0, 'recent is reset to 0');
  diag 'LOADING THE DATA FOR RUN 4799';
  lives_ok { $loader1->load; } 'loading data for one specific run lives';
  is (scalar $schema_wh->resultset('NpgInformation')->search->all, 8, '8 rows are now in the warehouse');
  is (scalar $schema_wh->resultset('NpgInformation')->search({id_run=>4799})->all, 8, 'these 8 rows are for run 4799');
}

{
  lives_ok { $schema_wh->resultset('NpgInformation')->delete_all } 'all rows deleted from the warehouse';
  is (scalar $schema_wh->resultset('NpgInformation')->search->all, 0, 'zero rows are now in the warehouse');

  my $loader1;
  lives_ok { $loader1 = npg_warehouse::loader->new(
                                              _autoqc_store => $autoqc_store,
                                              _schema_npg   => $schema_npg,
                                              _schema_qc    => $schema_qc,
                                              _schema_wh    => $schema_wh,
                                              recent        => 0,
                                              with_lims     => 0,
                                              id_run        => [6624,6642],
                                              _faster_globs => 0,
                                                 ) } 'loader object is created with id_run attr set';
  diag 'LOADING THE DATA FOR RUNS 6624,6642';
  lives_ok { $loader1->load; } 'loading data for two specific run lives';
  is (scalar $schema_wh->resultset('NpgInformation')->search->all, 16, '16 rows are now in the warehouse');
  is (scalar $schema_wh->resultset('NpgInformation')->search({id_run=>6624})->all, 8, 'these 8 rows are for run 6624');
  is (scalar $schema_wh->resultset('NpgInformation')->search({id_run=>6642})->all, 8, 'these 8 rows are for run 6642');

  my $lane = $schema_wh->resultset('NpgInformation')->find({id_run=>6642,position=>4});
  cmp_ok(sprintf('%.5f',$lane->verify_bam_id_score()), q(==), 0.00166, 'verify_bam_id_score');
  cmp_ok(sprintf('%.2f',$lane->verify_bam_id_average_depth()), q(==), 9.42, 'verify_bam_id_average_depth');
  cmp_ok($lane->verify_bam_id_snp_count(), q(==), 1531960, 'verify_bam_id_snp_count');

  $lane = $schema_wh->resultset('NpgInformation')->find({id_run=>6642,position=>3});
  cmp_ok(sprintf('%.2f',$lane->bam_num_reads()), q(==), 308368522, 'bam number of reads');
  cmp_ok(sprintf('%.2f',$lane->bam_percent_mapped()), q(==), 98.19, 'bam mapped percent');
  cmp_ok(sprintf('%.2f',$lane->bam_percent_duplicate()), q(==), 24.63, 'bam duplicate percent');

  $lane = $schema_wh->resultset('NpgInformation')->find({id_run=>6642,position=>1});
  is($lane->split_human_percent(), undef, 'split human percent not present');

  $lane = $schema_wh->resultset('NpgInformation')->find({id_run=>6642,position=>2});
  cmp_ok(sprintf('%.2f',$lane->split_human_percent()), q(==), 0.18, 'split human percent');

  my $plex = $schema_wh->resultset('NpgPlexInformation')->find({id_run=>6642,position=>2,tag_index=>4});
  cmp_ok(sprintf('%.2f',$plex->bam_human_percent_mapped()), q(==), 55.3, 'bam human mapped percent');
  cmp_ok(sprintf('%.2f',$plex->bam_human_percent_duplicate()), q(==), 68.09, 'bam human duplicate percent');
  cmp_ok(sprintf('%.2f',$plex->bam_num_reads()), q(==), 138756624, 'bam (nonhuman) number of reads');
  cmp_ok(sprintf('%.2f',$plex->bam_percent_mapped()), q(==), 96.3, 'bam (nonhuman) mapped percent');
  cmp_ok(sprintf('%.2f',$plex->bam_percent_duplicate()), q(==), 6.34, 'bam (nonhuman) duplicate percent');

  $lane = $schema_wh->resultset('NpgInformation')->find({id_run=>6624,position=>3});
  cmp_ok(sprintf('%.2f',$lane->split_phix_percent()), q(==), 0.44, 'split phix percent');
  $plex = $schema_wh->resultset('NpgPlexInformation')->find({id_run=>6624,position=>3,tag_index=>4});
  cmp_ok(sprintf('%.2f',$plex->bam_num_reads()), q(==), 33605036, 'bam number of reads');
  cmp_ok(sprintf('%.2f',$plex->bam_percent_mapped()), q(==), 96.12, 'bam (nonphix) mapped percent');
  cmp_ok(sprintf('%.2f',$plex->bam_percent_duplicate()), q(==), 1.04, 'bam (nonphix) duplicate percent');
  $plex = $schema_wh->resultset('NpgPlexInformation')->find({id_run=>6624,position=>3,tag_index=>1});
  cmp_ok(sprintf('%.2f',$plex->mean_bait_coverage()), q(==), 41.49, 'mean bait coverage');
  cmp_ok(sprintf('%.2f',$plex->on_bait_percent()), q(==), 68.06, 'on bait percent');
  cmp_ok(sprintf('%.2f',$plex->on_or_near_bait_percent()), q(==), 88.92, 'on or near bait percent');

  $lane = $schema_wh->resultset('NpgInformation')->find({id_run=>6624,position=>2});
  is($lane->q30_yield_kb_reverse_read, 9820023, 'q30 lane reverse');
  is($lane->q40_yield_kb_forward_read, 6887095, 'q40 lane forward'); 

  $lane = $schema_wh->resultset('NpgInformation')->find({id_run=>6624,position=>4});
  is($lane->q30_yield_kb_reverse_read, 11820778, 'q30 lane reverse');
  is($lane->q40_yield_kb_forward_read, 8315876,  'q40 lane forward');

  $plex = $schema_wh->resultset('NpgPlexInformation')->find({id_run=>6624,position=>4,tag_index=>0});
  is($plex->q30_yield_kb_reverse_read, 99353, 'q30 plex reverse');
  is($plex->q40_yield_kb_forward_read, 72788, 'q40 plex forward');

  $plex = $schema_wh->resultset('NpgPlexInformation')->find({id_run=>6624,position=>2,tag_index=>168});
  is($plex->q30_yield_kb_reverse_read, 304, 'q30 plex reverse');
  is($plex->q40_yield_kb_forward_read, 210, 'q40 plex forward'); 
}

{
  lives_ok { $schema_wh->resultset('NpgInformation')->delete_all } 'all rows deleted from the warehouse';
  is (scalar $schema_wh->resultset('NpgInformation')->search->all, 0, 'zero rows are now in the warehouse');

  my $loader;
  lives_ok { $loader = npg_warehouse::loader->new(
                                              _schema_npg   => $schema_npg,
                                              _schema_qc    => $schema_qc,
                                              _schema_wh    => $schema_wh,
                                              _autoqc_store => $autoqc_store,
                                              recent        => 0,
                                              with_lims     => 0,
                                              id_run        => [6624],
                                              _faster_globs => 0,
                                                 ) } 'loader object is created with id_run and recent attrs set';
  diag 'LOADING THE DATA FOR RUN 6624, autoqc from staging';
  lives_ok { $loader->load; } 'loading data for one run autoqc from staging lives';

  my $lane = $schema_wh->resultset('NpgInformation')->find({id_run=>6624,position=>3}); 
  cmp_ok(sprintf('%.2f',$lane->tags_decode_percent()), q(==), 99.05, 'lane 3 tag decode percent from tag decode stats in absence of tag metrics');
  $lane = $schema_wh->resultset('NpgInformation')->find({id_run=>6624,position=>2});
  cmp_ok(sprintf('%.2f',$lane->tags_decode_percent), q(==), 98.96, 'lane 2 tag decode percent from tag metrics in presence of tag decode stats');
  my $plex = $schema_wh->resultset('NpgPlexInformation')->find({id_run=>6624,position=>2,tag_index=>168});
  is($plex->tag_sequence(), 'ACAACGCA', 'lane 2 tag index 168 tag sequence');
  is($plex->tag_decode_count(), 1277701, 'lane 2 tag index 168 count');
  cmp_ok(sprintf('%.2f', $plex->tag_decode_percent()), q(==), 0.73, , 'lane 2 tag index 168 percent');
  $plex = $schema_wh->resultset('NpgPlexInformation')->find({id_run=>6624,position=>1,tag_index=>0});
  ok(!defined $plex->tag_sequence(), 'index zero tag sequence is not defined');
  is($plex->tag_decode_count(), 1831358, 'lane 1 tag index 0 count');
}

{
  $loader->update_run_statuses;
  is ($loader->_schema_wh->resultset('NpgRunStatusDict')->search({})->count, 24, '24 rows loaded to the run status dictionary');
  is ($loader->_schema_wh->resultset('NpgRunStatus')->search({})->count, 223, '223 rows loaded to the run status table');  
}

{
  my $id_run = 3965;
  my $loader = npg_warehouse::loader->new( 
                      _schema_wh => $schema_wh,
                      _schema_npg   => $schema_npg,
                      _schema_qc    => $schema_qc,
                      id_run     => [$id_run],
                                         );
  $loader->load();
  my $expected = { 
      1 => 0, 2 => 1, 3 => 1, 4 => undef, 5 => undef, 6 => undef, 7 => 1, 8 => 0,
  };
  my @pos = (1 .. 8);
  foreach my $position (@pos) {
    my $row = $schema_wh->resultset('NpgInformation')->search({id_run=>$id_run, position=>$position,})->next;
    is($row->manual_qc, $expected->{$position}, q{manual_qc through full run loading});
  }

  local $ENV{NPG_WEBSERVICE_CACHE_DIR} = q[t/data/npg_warehouse_loader_manual_qc];
  $loader->update_manual_qc;
  $expected = { 
      1 => 1, 2 => 0,  3 => 1, 4 => undef, 5 => 0, 6 => 1, 7 => undef, 8 => 0,
  };
  foreach my $position (@pos) {
    my $new_row = $schema_wh->resultset('NpgInformation')->search({id_run=>$id_run, position=>$position,})->next;
    is($new_row->manual_qc, $expected->{$position}, q{correct updated manual qc value});
  }
  local $ENV{NPG_WEBSERVICE_CACHE_DIR} = q[t/data/some];
  lives_ok {$loader->update_manual_qc} 'manual qc update without error despite an error withing the module';
} 

1;
