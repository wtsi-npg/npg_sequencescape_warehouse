use strict;
use warnings;
use Test::More;
use English qw(-no_match_vars);

if (!$ENV{TEST_AUTHOR}) {
  my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
  plan( skip_all => $msg );
}

eval {
  require Test::Perl::Critic;
  require Perl::Critic::Utils;
};

if($EVAL_ERROR) {
  plan skip_all => 'Test::Perl::Critic not installed';

} else {
  Test::Perl::Critic->import(
	-severity => 1,
        -profile  => 't/perlcriticrc',
        -verbose  => "%m at %f line %l, policy %p\n",
	-exclude  => [ 'tidy',
                   'ValuesAndExpressions::ProhibitImplicitNewlines',
                   'ValuesAndExpressions::RequireConstantVersion',
                   'Documentation::PodSpelling',
                   'Subroutines::ProhibitUnusedPrivateSubroutines',
                   'RegularExpressions::ProhibitEnumeratedClasses',
                   'RegularExpressions::ProhibitEscapedMetacharacters',
                   'Subroutines::ProtectPrivateSubs',
                   'Variables::ProhibitPunctuationVars',
                   'Documentation::RequirePodAtEnd'
                 ],
  );

  my @files = qw (lib/npg_warehouse/loader.pm
                lib/npg_warehouse/loader/lims.pm
                lib/npg_warehouse/Schema.pm
                lib/npg_warehouse/Schema/Result/NpgInformation.pm
                lib/npg_warehouse/Schema/Result/NpgPlexInformation.pm
                lib/npg_warehouse/Schema/Result/CurrentStudy.pm
                lib/npg_warehouse/Schema/Result/CurrentSample.pm
               );
  push @files, Perl::Critic::Utils::all_perl_files(
    'bin', 'lib/srpipe', 'lib/npg_common', 'lib/npg_validation');
  foreach my $file (@files) {
    critic_ok($file);
  }
  done_testing(scalar @files);
}

1;
