use strict;
use warnings;
use Carp;
use Test::More tests => 115;
use Test::Exception;
use st::api::lims;

local $ENV{NPG_WEBSERVICE_CACHE_DIR} = q[t/data/npg_warehouse_loader];

use_ok('npg_warehouse::loader::lims');

my $plex_key = q[plexes];

{
  my $lims = st::api::lims->new(driver_type => 'xml', batch_id => 6669);
  my $l;
  lives_ok {$l  = npg_warehouse::loader::lims->new(plex_key => $plex_key, lims => $lims)}
    'object instantiated';
  isa_ok ($l, 'npg_warehouse::loader::lims');
}

{
  my @positions = qw/ 1 4 7 /;
  my @runs = qw/ 4025 4799 /;
  my @batch_ids = qw/4965 6669/;
  my @plex_fields = qw/ asset_id asset_name sample_id study_id library_type/;
  my @fields = @plex_fields;

  my $expected = {
  4965 => {
  1 => {asset_id=>'59157',asset_name=>'B1267_Exp4 1', sample_id=>'9272', lane_type=>'library', study_id => 377, library_type=>'qPCR only',},
  4 => {asset_id=>'79577',asset_name=>'phiX CT1462-2 1', sample_id=>'9836', lane_type=>'control', study_id => undef, library_type=>undef,},
  7 => {asset_id=>'59259',asset_name=>'NA18563pd2a 1', sample_id=>'9388', lane_type=>'library', study_id => 188, library_type=>'qPCR only',},
        },
  6669 => {
  1 => {asset_id=>'236583',asset_name=>'O157_Input 236583', sample_id=>'112662', lane_type=>'library', study_id => 576, library_type=>'Custom',},
  4 => {asset_id=>'79572',asset_name=>'phiX_SI_SPRI 1', sample_id=>'9831', lane_type=>'control',study_id => undef, library_type=>undef,},
  7 => {asset_id=>'236519',asset_name=>'26May2010', lane_type=>'pool', sample_id => undef, study_id => 590, library_type=>'Custom',},
       } 
  };

  my $plexes = {
  1 => {asset_id=>'236515',asset_name=>'U266 236515', sample_id=>'112635', study_id=>590, library_type=>'Custom',},
  2 => {asset_id=>'236516',asset_name=>'10E-4NPM1_U266 236516', sample_id=>'112636', study_id=>590, library_type=>'Custom',},
  3 => {asset_id=>'236517',asset_name=>'10E-3NPM1_U266 236517', sample_id=>'112637', study_id=>590, library_type=>'Custom',},
  4 => {asset_id=>'236518',asset_name=>'10E-2NPM1_U266 236518', sample_id=>'112638', study_id=>590, library_type=>'Custom',},
               };

  foreach my $batch_id (@batch_ids) {
    my $lims = st::api::lims->new(driver_type => 'xml', batch_id => $batch_id);
    my $l  = npg_warehouse::loader::lims->new(plex_key => $plex_key, lims => $lims);
    my $run_meta = $l->retrieve();
    foreach my $position (@positions) {
      foreach my $field (@fields) {
        if (exists $expected->{$batch_id}->{$position}->{$field}) {
          is ($run_meta->{$position}->{$field}, $expected->{$batch_id}->{$position}->{$field}, 
              qq[$field for batch $batch_id, position $position]);
        } else {
          ok (!exists $run_meta->{$position}->{$field},
            qq[$field for batch $batch_id, position $position not defined]);
        }
      }
      if ($batch_id == 6669) {
        if ($position != 7) {
          ok (!exists $run_meta->{$position}->{$plex_key},
            qq[plex meta info does not exists for batch $batch_id, position $position]);
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
  my $lims = st::api::lims->new(driver_type => 'xml', batch_id => 12509);
  my $l = npg_warehouse::loader::lims->new(plex_key => $plex_key, lims => $lims);
  my $meta  = $l->retrieve();
  is ($meta->{1}->{spike_tag_index}, '168', 'spike tag index for lane 1');
  is ($meta->{3}->{spike_tag_index}, '168', 'spike tag index for lane 3');
  is ($meta->{5}->{spike_tag_index}, '168', 'spike tag index for lane 5');
  ok (!exists $meta->{1}->{$plex_key}->{1}->{spike_tag_index},
    'spike tag index field not present for a plex');
}

{
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
  
  foreach my $batch_id (@batch_ids) {
    my $lims = st::api::lims->new(driver_type => 'xml', batch_id => $batch_id);
    my $l = npg_warehouse::loader::lims->new(plex_key => $plex_key, lims => $lims);
    my $run_meta = $l->retrieve();
    foreach my $position (qw /1 2 3 4 5 6 7 8/) {
      is ($run_meta->{$position}->{'manual_qc'}, $manual_qc->{$batch_id}->{$position}, 
              qq[manual qc for batch $batch_id, position $position]);
      if (exists $run_meta->{$position}->{$plex_key}) {
        ok (!exists $run_meta->{$position}->{$plex_key}->{'manual_qc'},
              q[manual qc entry does not exist on plex level]);
      }
    }
  }
}

1;
