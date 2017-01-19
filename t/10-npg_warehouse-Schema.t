use strict;
use warnings;
use Test::More tests => 21;
use Test::Exception;
use English;
use t::npg_warehouse::util;


BEGIN{
  use_ok ( 'npg_warehouse::Schema' );
}

my $schemas = {
  live   => undef,
  test   => undef,
  #dev    => undef,
};

foreach my $env (keys %{$schemas}) {
   if ($env ne q[test]) {
     local $ENV{dev} = $env;
     my $s;
     my $error = q[];
     eval {
       $s = npg_warehouse::Schema->connect();
       1;
     } or do {
       $error = $EVAL_ERROR;
     };
     SKIP: {
       skip "Failed to connect to $env warehouse database.", 1 unless !$error;
       isa_ok($s, 'npg_warehouse::Schema', "npg_warehouse::Schema for $env database");
       $schemas->{$env} = $s;
     }
   } else { 
     my $util = t::npg_warehouse::util->new();
     my $schema_package = q[npg_warehouse::Schema];
     my $fixtures_path = q[t/data/fixtures/warehouse];
     lives_ok {$schemas->{test} = $util->create_test_db($schema_package, $fixtures_path)} qq[$env database created];
   }
}

my $names = { 
              live => {sample=>'AC0001C', lib =>'AC0001C 1', study=>'Anopheles gambiae genome variation 1',},
              test => {sample=>'3055',    lib =>'AC0001C 1', study=>'544',}, 
            };
$names->{dev} = $names->{live};

#####################  tests against the available schemas  #######################
foreach my $key (keys %{$schemas}) {

  my $s = $schemas->{$key};
  if ($s) {diag $s;}

        SKIP: {
        skip "No $key database for testing available", 9 unless $s;

  my $rs;
  lives_ok {
{
    $rs=$s->resultset(q(NpgInformation));
    ok (defined $rs, "$key db: NpgInformation resultset");
    ok ($rs->count, "$key db: NpgInformation resultset has data");
    $rs = $rs->search({id_run=>3500});
    cmp_ok($rs->count,'==',8, "$key db: lane count for run 3500");
    my $l = $rs->find({position=>9});
    ok (!defined $l, "$key db: no data for non-existant lane");
    $l = $rs->find({position=>1});
    ok (defined $l, "$key db: data for lane 1");
    is ($l->sample_name, $names->{$key}->{sample}, "$key db: sample name for lane 1");
    is ($l->study_name, $names->{$key}->{study}, "$key db: study name for lane 1");
    cmp_ok($l->library_name,'eq',$names->{$key}->{lib}, "$key db: library name");
}
  } "$key db: get DBIC NpgInformation resultset";

        }
}
