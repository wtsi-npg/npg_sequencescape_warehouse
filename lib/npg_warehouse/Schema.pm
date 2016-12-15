
package npg_warehouse::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-29 10:46:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:R8ea9/5ZIcfZU2PXYKtAFw

#########
# Author:        Marina Gourtovaia
# Maintainer:    $Author$
# Created:       23 June 2010
# Last Modified: $Date$
# Id:            $Id$
# $HeadURL$

use Readonly; Readonly::Scalar our $VERSION => do { my ($r) = q$LastChangedRevision$ =~ /(\d+)/mxs; $r; };

with qw/npg_tracking::util::db_connect/;

sub sqlt_deploy_hook {
  my ($self, $sqlt_schema) = @_;
  my $db_type = $sqlt_schema->translator->producer_type;
  $db_type  =~ s/^SQL::Translator::Producer:://smx;
  if ($db_type eq 'SQLite') {
    my @tables = grep { !( /^current_/smx || /^npg_/smx ) } $sqlt_schema->get_tables;
    foreach my $table_name (@tables) {
      $sqlt_schema->drop_table($table_name);
    }
  }
  return;
}

1;
__END__

=head1 NAME

npg_warehouse::Schema

=head1 SYNOPSIS

=head1 DESCRIPTION

A Moose class for a DBIx schema with an ability to retrieve db cridentials
from a configuration file. Provides a schema object for a DBIx binding
for the warehouse database.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook

 A hook for the DBIx schema deploy method. If the schema is deployed to SQLite database,
 only table starting with current_ and npg_ are created to avoid warnings of the following type:

 DBIx::Class::Storage::DBI::__ANON__(): DBIx::Class::Schema::deploy(): DBI Exception: DBD::SQLite::db do failed: index uuid_and_current_from_and_c00 already exists [for Statement "CREATE UNIQUE INDEX uuid_and_current_from_and_c00 ON study_samples (uuid, current_from, current_to)"]
 (running "CREATE UNIQUE INDEX uuid_and_current_from_and_c00 ON study_samples (uuid, current_from, current_to)") 

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Readonly

=item Moose

=item MooseX::MarkAsMethods

=item DBIx::Class::Schema

=item npg_tracking::util::db_connect

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2016 GRL

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
