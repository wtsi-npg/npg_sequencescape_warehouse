use strict;
use warnings;
use Carp;
use Test::More tests => 245;
use Test::Exception;
use Test::Warn;
use Test::Deep;
use DateTime;

use npg_warehouse::loader::autoqc;

local $ENV{NPG_WEBSERVICE_CACHE_DIR} = q[t/data/npg_warehouse_loader];

use_ok('npg_warehouse::loader::lims');

my $plex_key = q[plexes];

{
  my $l;
  lives_ok {$l  = npg_warehouse::loader::lims->new( plex_key => $plex_key, recent => 0)} 'object instantiated';
  isa_ok ($l, 'npg_warehouse::loader::lims');
  is ($l->recent, 0, 'recent attr is false');
}

{
  throws_ok {npg_warehouse::loader::lims->new()} qr/Attribute \(plex_key\) is required/,
        'error in constructor when plex key attr is not defined';
}

{
  local $ENV{NPG_WEBSERVICE_CACHE_DIR} = q[];
  my $l1   = npg_warehouse::loader::lims->new(plex_key => $plex_key, recent => 0);
  my $date = DateTime->now(time_zone => 'floating');
  my $meta = {};
  my $batch_id = 0;
  cmp_deeply($l1->retrieve($batch_id, $date), $meta,  qq[meta info for batch $batch_id is an empty hash]);
}

{
  my $l  = npg_warehouse::loader::lims->new(plex_key => $plex_key, recent => 0);
  my $date = DateTime->now(time_zone => 'floating');
  is ($l->is_recent(), 1, 'any run is recent when recent flag is false');

  $l  = npg_warehouse::loader::lims->new(plex_key => $plex_key, recent => 1);
  is ($l->recent, 1, 'recent attr is true');
  is ($l->is_recent($date), 1, 'run is recent when the date is today');
  $date->subtract(days => 49);
  is ($l->is_recent($date), 1, 'run is recent when the date is 49 days ago');
  $date->subtract(days => 1);
  is ($l->is_recent($date), 0, 'run is not recent when the date is 50 days ago');
  $date->subtract(days => 1);
  is ($l->is_recent($date), 0, 'run is not recent when the date is 51 days ago');
  my $is_recent = 1;
  warning_like { $is_recent = $l->is_recent() } qr/no date to evaluate/, 'warning  when no date is not supplied';
  is ($is_recent, 0,  'run is not recent when no date is not supplied');
}

{
  my @positions = qw /1 2 3 4 5 6 7 8/;
  my @batch_ids = qw/2044 4354 4178 4445 4380 4915 4965/;
  my $manual_qc = {
  2044 => {1=>undef, 2=>undef, 3=>undef, 4=>undef, 5=>undef, 6=>undef, 7=>undef, 8=>undef,},
  4354 => {1=>1, 2=>1, 3=>1, 4=>undef, 5=>1, 6=>1, 7=>0, 8=>1,},
  4178 => {1=>1, 2=>1, 3=>1, 4=>undef, 5=>1, 6=>1, 7=>0, 8=>1,},
  4445 => {1=>1, 2=>1, 3=>0, 4=>undef, 5=>1, 6=>1, 7=>1, 8=>1,},
  4380 => {1=>0, 2=>0, 3=>0, 4=>undef, 5=>0, 6=>undef, 7=>undef, 8=>0,},
  4915 => {1=>0, 2=>1, 3=>1, 4=>undef, 5=>undef, 6=>undef, 7=>1, 8=>0,},
  4965 => {1=>1, 2=>1, 3=>1, 4=>undef, 5=>1, 6=>1, 7=>1, 8=>1,},
                  };
  my $date = DateTime->now(time_zone => 'floating');
  $date->subtract(days => 60);

  my $l  = npg_warehouse::loader::lims->new(plex_key => $plex_key, recent => 0);
  my $is_cancelled = 0;
  foreach my $batch_id (@batch_ids) {
    my $run_meta = $l->retrieve($batch_id, $date, $is_cancelled);
    foreach my $position (@positions) {
      is ($run_meta->{$position}->{manual_qc}, $manual_qc->{$batch_id}->{$position}, 
              qq[manual qc for batch $batch_id, position $position]);
      is ($run_meta->{$position}->{is_dev}, 0, 'id_dev is 0');
    }
  }

  my $batch_id = 4915;
  my $manual_qc_meta = $l->retrieve_manual_qc($batch_id);
  foreach my $position (@positions) {
    is ($manual_qc_meta->{$position}->{manual_qc}, $manual_qc->{$batch_id}->{$position}, 
              qq[manual qc for batch $batch_id, position $position]);
  }
  my $position = 1;
  is ($manual_qc_meta->{$position}->{$plex_key}, undef, 'retrieve_manual_qc_data does not retrieve anything at plex level');
  is (scalar keys $manual_qc_meta->{$position}, 1, 'retrieve_manual_qc_data does not retrieve anything other than manual_qc at lane level');

  $is_cancelled = 1;
  foreach my $position (@positions) {
    my $run_meta = $l->retrieve(4354, $date, $is_cancelled);
    is ($run_meta->{$position}->{manual_qc}, undef, q[manual qc for cancelled batch is undef]);
  }
}

{
  my @positions = qw/ 1 4 7 /;
  my @runs = qw/ 4025 4799 /;
  my @batch_ids = qw/4965 6669/;
  my @plex_fields = qw/ asset_id asset_name sample_id study_id project_id library_type/;
  my @fields = @plex_fields;
  push @fields, qw/request_id request_type is_dev/;
  my $date = DateTime->now(time_zone => 'floating');

  my $expected = {
  4965 => {
  1 => {asset_id=>'59157',asset_name=>'B1267_Exp4 1', sample_id=>'9272', request_id=>'2913038', lane_type=>'library',is_dev => 0, study_id => 377, project_id => 377, library_type=>'qPCR only',},
  4 => {asset_id=>'79577',asset_name=>'phiX CT1462-2 1', sample_id=>'9836', request_id=>'43885', lane_type=>'control',is_dev => 0, study_id => undef, project_id => undef, library_type=>undef,},
  7 => {asset_id=>'59259',asset_name=>'NA18563pd2a 1', sample_id=>'9388', request_id=>'39455', lane_type=>'library',is_dev => 1, study_id => 188, project_id => 188, library_type=>'qPCR only',},
        },
  6669 => {
  1 => {asset_id=>'236583',asset_name=>'O157_Input 236583', sample_id=>'112662', request_id=>'550377', lane_type=>'library',is_dev => 1, study_id => 576, project_id => 576, library_type=>'Custom',},
  4 => {asset_id=>'79572',asset_name=>'phiX_SI_SPRI 1', sample_id=>'9831', request_id=>'550403', lane_type=>'control',is_dev => 0, study_id => undef, project_id => undef, library_type=>undef,},
  7 => {asset_id=>'236519',asset_name=>'26May2010', request_id=>'550401', lane_type=>'pool', sample_id => undef, is_dev => 1, study_id => 590, project_id => 46, library_type=>'Custom',},
       } 
  };

  my $plexes = {
  1 => {asset_id=>'236515',asset_name=>'U266 236515', sample_id=>'112635', study_id=>590, project_id=>46, library_type=>'Custom',},
  2 => {asset_id=>'236516',asset_name=>'10E-4NPM1_U266 236516', sample_id=>'112636', study_id=>590, project_id=>46, library_type=>'Custom',},
  3 => {asset_id=>'236517',asset_name=>'10E-3NPM1_U266 236517', sample_id=>'112637', study_id=>590, project_id=>46, library_type=>'Custom',},
  4 => {asset_id=>'236518',asset_name=>'10E-2NPM1_U266 236518', sample_id=>'112638', study_id=>590, project_id=>46, library_type=>'Custom',},
               };

  my $l  = npg_warehouse::loader::lims->new(plex_key => $plex_key, recent => 0, dev_cost_codes => [qw/S0700 S0755 S0696/]);

  foreach my $batch_id (@batch_ids) {
    my $run_meta = $l->retrieve($batch_id, $date);
    foreach my $position (@positions) {
      foreach my $field (@fields) {
        if (exists $expected->{$batch_id}->{$position}->{$field}) {
          is ($run_meta->{$position}->{$field}, $expected->{$batch_id}->{$position}->{$field}, 
              qq[$field for batch $batch_id, position $position]);
        } else {
          ok (!exists $run_meta->{$position}->{$field},  qq[$field for batch $batch_id, position $position not defined]);
        }
      }
      if ($batch_id == 6669) {
        if ($position != 7) {
          ok (!exists $run_meta->{$position}->{$plex_key}, qq[plex meta info does not exists for batch $batch_id, position $position]);
        } else {
          foreach my $tag_index (keys %{$plexes}) {
            foreach my $field (@plex_fields) {
             is ($run_meta->{$position}->{$plex_key}->{$tag_index}->{$field}, $plexes->{$tag_index}->{$field}, 
              qq[$field for batch $batch_id, position $position tag index $tag_index]); 
            }
          }
        }
      }
    }
  }
}

{
  my $l1   = npg_warehouse::loader::lims->new(plex_key => $plex_key, recent => 1);
  my @positions = qw/1 2 3 4 5 6 7 8/;
  my $date = DateTime->now(time_zone => 'floating');
  
  my $batch_id = 4915;
  my $run_meta = $l1->retrieve(4915, $date);
  my @expected_qc = (0,1,1,undef,undef,undef,1,0);
  foreach my $position (@positions) {
    is($run_meta->{$position}->{manual_qc}, $expected_qc[$position-1], qq[manual qc for batch $batch_id position $position]);
  }

  $batch_id = 4965;
  $run_meta = $l1->retrieve($batch_id, $date);
  @expected_qc = (1,1,1,undef,1,1,1,1);
  foreach my $position (@positions) {
    is($run_meta->{$position}->{manual_qc}, $expected_qc[$position-1], qq[manual qc for batch $batch_id position $position]);
  }

  $date->subtract(days => 60);
  $batch_id = 4915;
  my $meta = {};
  cmp_deeply($l1->retrieve($batch_id, $date), $meta,  qq[meta info for batch $batch_id is an empty hash]);
}

{
  my $meta  = npg_warehouse::loader::lims->new(plex_key => $plex_key, recent => 0)->retrieve(12509);
  is ($meta->{1}->{spike_tag_index}, '168', 'spike tag index for lane 1');
  is ($meta->{3}->{spike_tag_index}, '168', 'spike tag index for lane 3');
  is ($meta->{5}->{spike_tag_index}, '168', 'spike tag index for lane 5');
  ok (!exists $meta->{1}->{$plex_key}->{1}->{spike_tag_index}, 'spike tag index field not present for a plex');
}

1;
