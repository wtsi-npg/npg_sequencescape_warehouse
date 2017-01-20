use strict;
use warnings;
use Module::Build;

our $VERSION = '0';

my $requires = {
                    'perl'                      => '5.010',
                    'Carp'                      => 0,
                    'Cwd'                       => 0,
                    'Date::Calc'                => 0,
                    'DateTime'                  => 0,
                    'DBIx::Class'               => 0,
                    'DBIx::Class::Schema::Loader' => 0,
                    'English'                   => 0,
                    'File::Basename'            => 0,
                    'File::Slurp'               => 0,
                    'File::Spec'                => 0,
                    'File::Spec::Functions'     => 0,
                    'FindBin'                   => 0,
                    'Getopt::Long'              => '2.37',
                    'JSON'                      => 0,
                    'List::MoreUtils'           => 0,
                    'List::Util'                => 0,
                    'LWP::UserAgent'            => 0,
                    'Moose'                     => 0,
                    'Moose::Role'               => 0,
                    'Moose::Util::TypeConstraints' => 0,
                    'MooseX::Getopt'             => 0,
                    'MooseX::MarkAsMethods'     => 0,
                    'MooseX::NonMoose'          => 0,
                    'MooseX::StrictConstructor' => 0,
                    'namespace::autoclean'      => 0,
                    'Perl6::Slurp'              => 0,
                    'Pod::Usage'                => 0,
                    'POSIX'                     => '1.09',
                    'strict'                    => 0,
                    'Try::Tiny'                 => 0,
                    'warnings'                  => 0,
                    'XML::LibXML'               => 0,

                    'npg_qc::Schema'                          => 0,
                    'npg_qc::autoqc::role::result'            => 0,
                    'npg_qc::autoqc::qc_store'                => 0,
                    'npg_tracking::Schema'                    => 0,
                    'npg_tracking::util::db_connect'          => 0,
                    'st::api::lims'                           => 0,
};

my $builder = Module::Build->new(
                 'module_name'         => 'data_handling',
                 'dist_author'         => q(npg <npg@sanger.ac.uk>),
                 'dist_version_from'   => q(lib/npg_warehouse/Schema.pm),
                 'dist_abstract'       => q(LIMS warehouse DBIx binding&loader),
                 'license'             => 'gpl',

		 'configure_requires'  => {
                    'Readonly'                  => 0,
                    'Readonly::XS'              => 0,
                 },

		 'build_requires'      => {
                    'Archive::Tar'                => 0,
                    'File::Temp'                  => 0,
                    'File::Path'                  => 0,
                    'Test::Compile'               => 0,
                    'Test::Deep'                  => 0,
                    'Test::Distribution'          => 0,
                    'Test::Exception'             => 0,
                    'Test::More'                  => '0.8',
                    'Test::Perl::Critic'          => 0,
                    'Test::Pod'                   => '1.00',
                    'Test::Pod::Coverage'         => '1.04',
                    'Test::Warn'                  => 0,
                    'YAML'                        => 0,
                    'npg_testing::db'             => 0,
                 },

                 'requires'            => $requires,
);

$builder->create_build_script();
