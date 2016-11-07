################
# Created by: ajb
# Maintainer: $Author$
# Created on: 2009-04-08
# Last Changed: $Date$
# Id: $Id$
# $HeadURL$

use strict;
use warnings;
use Module::Build;

our $VERSION = do { my @r = (q$Revision$ =~ /\d+/mxgs); sprintf '%d.'.'%03d' x $#r, @r };

my $class = Module::Build->subclass(code => <<'EOF');

  sub process_cgi_files {
    `find cgi-bin -type f | grep -v .svn | cpio -pdv --quiet blib`;
    `chmod +x blib/cgi-bin/*`;
    return;
  }

  sub ACTION_webinstall {
    my $self = shift;
    $self->install_path('cgi-bin' => join q{/}, $self->install_base(), 'cgi-bin');
    $self->add_build_element('cgi');
    $self->depends_on("install");
    return;
  }
EOF

my $requires = {
                    'perl'                      => '5.010',
                    'base'                      => 0,
                    'Carp'                      => 0,
                    'CGI'                       => 0,
                    'Cwd'                       => 0,
                    'Class::Accessor'           => 0,
                    'Date::Calc'                => 0,
                    'DateTime'                  => 0,
                    #'DBD::Oracle'               => 0, #not required for tests and thwarts gseq install
                    'DBI'                       => 0,
                    'DBIx::Class'               => 0,
                    'DBIx::Class::Schema::Loader' => 0,
                    'Digest::MD5'               => 0,
                    'English'                   => 0,
                    'File::Basename'            => 0,
                    'File::Copy'                => 0,
                    'File::Find'                => 0,
                    'File::Glob'                => 0,
                    'File::Path'                => 0,
                    'File::Slurp'               => 0,
                    'File::Spec'                => 0,
                    'File::Spec::Functions'     => 0,
                    'FindBin'                   => 0,
                    'Getopt::Long'              => '2.37',
                    'Getopt::Std'               => 0,
                    'GD'                        => 0,
                    'IPC::Open3'                => 0,
                    'JSON'                      => 0,
                    'List::MoreUtils'           => 0,
                    'List::Util'                => 0,
                    'LWP::UserAgent'            => 0,
                    'MIME::Lite'                => 0,
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
                    'Time::HiRes'               => 0,
                    'Try::Tiny'                 => 0,
                    'warnings'                  => 0,
                    'XML::LibXML'               => 0,
                    'YAML'                      => 0,

                    'npg_common::roles::log'                  => 0,

                    'npg_qc::illumina::loader'                => 0,
                    'npg_qc::Schema'                          => 0,
                    'npg_qc::autoqc::role::result'            => 0,
                    'npg_qc::autoqc::qc_store'                => 0,
                    'npg_tracking::data::reference'           => 0,
                    'npg_tracking::data::reference::find'     => 0,
                    'npg_tracking::glossary::run'             => 0,
                    'npg_tracking::illumina::run::folder::validation' => 0,
                    'npg_tracking::illumina::run::folder'     => 0,
                    'npg_tracking::illumina::run::long_info'  => 0,
                    'npg_tracking::illumina::run::short_info' => 0,
                    'npg_tracking::Schema'                    => 0,
                    'npg_tracking::util::db_connect'          => 0,
                    'st::api::lims'                           => 0,

                    'WTSI::NPG::iRODS'                        => '>= 2.3.0',
                    'npg_pipeline::cache'                     => 0,
};

my $builder = $class->new(
                 'module_name'         => 'data_handling',
                 'dist_author'         => q(npg <npg@sanger.ac.uk>),
                 'dist_version_from'   => q(lib/srpipe/runfolder.pm),
                 'dist_abstract'       => q(LIMS warehouse DBIx binding&loader, Illumina images loader&viewer),
                 'license'             => 'gpl',

		 'configure_requires'  => {
                    'Readonly'                  => 0,
                    'Readonly::XS'              => 0,
                 },

		 'build_requires'      => {
                    'Archive::Tar'                => 0,
                    'File::Basename'              => 0,
                    'Test::Compile'               => 0,
                    'File::Temp'                  => 0,
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
