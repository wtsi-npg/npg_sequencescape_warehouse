use strict;
use warnings;
use lib 'lib';

use WTSI::DNAP::Utilities::Build;

my $builder = WTSI::DNAP::Utilities::Build->new(

                 'module_name'    => 'npg_sequencescape_warehouse',
                 'dist_author'    => q(npg <npg@sanger.ac.uk>),
                 'dist_version'   => WTSI::DNAP::Utilities::Build->report_version(),
                 'dist_abstract'  => q(Sequencescape LIMs warehouse DBIx binding&loader),
                 'license'        => 'gpl',

		 'configure_requires'  => {
                    'ExtUtils::CBuilder'        => 0,
                    'Module::Build'             => '>= 0.42',
                 },

		 'build_requires'      => {
                    'Test::Compile'               => 0,
                    'Test::Distribution'          => 0,
                    'Test::Exception'             => 0,
                    'Test::More'                  => '0.8',
                    'Test::Perl::Critic'          => 0,
                    'Test::Pod'                   => '1.00',
                    'npg_testing::db'             => 0,
                 },

                 'requires'            => {
                    'perl'                      => '5.010',
                    'Carp'                      => 0,
                    'DateTime'                  => 0,
                    'DBIx::Class'               => 0,
                    'DBIx::Class::Schema::Loader' => 0,
                    'English'                   => 0,
                    'File::Basename'            => 0,
                    'FindBin'                   => 0,
                    'Getopt::Long'              => '2.37',
                    'Moose'                     => 0,
                    'Moose::Util::TypeConstraints' => 0,
                    'MooseX::Getopt'             => 0,
                    'MooseX::MarkAsMethods'     => 0,
                    'MooseX::NonMoose'          => 0,
                    'MooseX::StrictConstructor' => 0,
                    'Pod::Usage'                => 0,
                    'Readonly'                  => 0,
                    'Readonly::XS'              => 0,
                    'strict'                    => 0,
                    'warnings'                  => 0,

                    'npg_qc::Schema'                => 0,
                    'npg_qc::autoqc::qc_store'      => 0,
                    'npg_qc::autoqc::role::rpt_key' => 0,
                    'npg_tracking::Schema'          => 0,
                    'st::api::lims'                 => 0,
                    'npg_warehouse::loader::autoqc' => 0,
                    'npg_warehouse::loader::npg'    => 0,
                    'npg_warehouse::loader::qc'     => 0,
               }
);

$builder->create_build_script();
