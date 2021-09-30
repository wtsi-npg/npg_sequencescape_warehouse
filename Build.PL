use strict;
use warnings;
use lib 'lib';

use WTSI::DNAP::Utilities::Build;

my $builder = WTSI::DNAP::Utilities::Build->new(

                 'module_name'    => 'npg_sequencescape_warehouse',
                 'dist_author'    => q(npg <npg@sanger.ac.uk>),
                 'dist_version'   => WTSI::DNAP::Utilities::Build->report_version(),
                 'dist_abstract'  => q(Sequencescape LIMS warehouse DBIx binding),
                 'license'        => 'gpl',

     'configure_requires'  => {
                    'ExtUtils::CBuilder'        => 0,
                    'Module::Build'             => '>= 0.42',
                 },

     'build_requires'      => {
                    'Test::Distribution'          => 0,
                    'Test::Exception'             => 0,
                    'Test::More'                  => '0.8',
                    'Test::Pod'                   => '1.00',
                    'npg_testing::db'             => 0,
                 },

                 'requires'            => {
                    'Carp'                      => 0,
                    'DBIx::Class'               => 0,
                    'DBIx::Class::Schema::Loader' => 0,
                    'Moose'                     => 0,
                    'MooseX::MarkAsMethods'     => 0,
                    'MooseX::NonMoose'          => 0,
                    'Readonly'                  => 0,
                    'Readonly::XS'              => 0,
                    'Try::Tiny'                 => 0,
                    'strict'                    => 0,
                    'warnings'                  => 0,
                }
);

$builder->create_build_script();
