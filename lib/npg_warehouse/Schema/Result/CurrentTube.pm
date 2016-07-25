#########
# Author:        David K Jackson <david.jackson@sanger.ac.uk>
# Created:       16 July 2013
package npg_warehouse::Schema::Result::CurrentTube;
use strict;
use warnings;

use base qw/DBIx::Class::Core/;
use Readonly;
__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

Readonly::Hash our %COMMON_COLUMNS => {
  'uuid',
  { data_type => 'binary', is_nullable => 0, size => 16 },
  'internal_id',
  { data_type => 'integer', is_nullable => 0 },
  'name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'barcode_prefix',
  { data_type => 'varchar', is_nullable => 1, size => 2 },
  'two_dimensional_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
};
Readonly::Array our @COMMON_COLUMNS => keys %COMMON_COLUMNS;
Readonly::Array our @UNION_TABLES   => qw(current_sample_tubes current_library_tubes current_multiplexed_library_tubes);
Readonly::Scalar our $TABLE_NAME    => 'current_tubes';

__PACKAGE__->table('current_tubes');
__PACKAGE__->result_source_instance->is_virtual(1);
__PACKAGE__->result_source_instance->view_definition(
  'SELECT * FROM ( '. ( join ' UNION ', map {'SELECT '.(join', ',@COMMON_COLUMNS)." FROM $_"} @UNION_TABLES ) ." ) $TABLE_NAME"
);
__PACKAGE__->add_columns(%COMMON_COLUMNS);
__PACKAGE__->add_unique_constraint('internal_id_idx', ['internal_id']);
__PACKAGE__->add_unique_constraint('uuid_idx', ['uuid']);

=head2 aliquots

Type: has_many

Related object: L<npg_warehouse::Schema::Result::CurrentAliquot>

=cut

__PACKAGE__->has_many(
  "aliquots",
  "npg_warehouse::Schema::Result::CurrentAliquot",
  { "foreign.receptacle_internal_id" => "self.internal_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

1;
