#########
# Author:        mg8
# Last Modified: $Date: 2010-02-19 16:13:49 +0000 (Fri, 19 Feb 2010) $ $Author: mg8 $
# Id:            $Id: util.pm 8322 2010-02-19 16:13:49Z mg8 $
# $HeadURL: svn+ssh://svn.internal.sanger.ac.uk/repos/svn/new-pipeline-dev/npg-catalyst-qc/trunk/npg_qc_viewer/t/util.pm $
#

package t::npg_warehouse::util;

use strict;
use warnings;
use Carp;
use English qw{-no_match_vars};
use Moose;
use Readonly;

with 'npg_testing::db';

our $VERSION = do { my ($r) = q$LastChangedRevision: 8322 $ =~ /(\d+)/mx; $r; };

no Moose;
1;
