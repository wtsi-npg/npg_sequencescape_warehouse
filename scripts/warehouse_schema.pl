#!/usr/bin/env perl

use strict;
use warnings;
use Carp;
use Config::Auto;
use DBIx::Class::Schema::Loader qw(make_schema_at);
use Readonly;

Readonly::Scalar our $NPG_CONF_DIR   => q[.npg];
Readonly::Scalar our $CONF_FILE_NAME => q[npg_warehouse-Schema];

my $domain = $ENV{dev}||q[live];
my $schema_class_name = q[npg_warehouse::Schema];

carp qq[SCHEMA CLASS NAME $schema_class_name, DOMAIN $domain];

my $path = join q[/], $ENV{'HOME'}, $NPG_CONF_DIR, $CONF_FILE_NAME;
my $config = Config::Auto::parse($path);
if (defined $config->{$domain}) {
  $config = $config->{$domain};
}

make_schema_at(
          $schema_class_name, 
          { 
            debug           => 0, 
            dump_directory  => q[lib], 
            naming          => q[current],
            components      => [qw(InflateColumn::DateTime)],
            skip_load_external => 1,
            use_moose       => 1,

            filter_generated_code => sub {
              my ($type, $class, $text) = @_;
              my $code = $text;
              $code =~ s/use\ utf8;//;
              $code =~ tr/"/'/;
              if ($type eq 'result') {
                $code =~ s/=head1\ NAME/\#\#no\ critic\(RequirePodAtEnd\ RequirePodLinksIncludeText\ ProhibitMagicNumbers\ ProhibitEmptyQuotes\)\n\n=head1\ NAME/;
              }
              return $code;
            },
          }, 
          [ $config->{'dsn'}, $config->{'dbuser'}, $config->{'dbpass'}]
              );

1;
