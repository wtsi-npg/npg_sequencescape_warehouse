use strict;
use warnings;
use Test::More tests => 2;
use Test::Exception;
use t::npg_warehouse::util;

use_ok ( 'npg_warehouse::Schema' );

my $util = t::npg_warehouse::util->new();
lives_ok {$util->create_test_db(q[npg_warehouse::Schema], q[t/data/fixtures/warehouse])}
  qq[test database created];

1;