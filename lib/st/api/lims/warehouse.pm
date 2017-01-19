package st::api::lims::warehouse;
use Moose;
use MooseX::StrictConstructor;
use Moose::Util::TypeConstraints;
use Carp;
use npg_warehouse::Schema;
use st::api::lims;
use npg_warehouse::Schema::Result::CurrentAliquot;

our $VERSION = '0';

=head1 NAME

st::api::lims::warehouse

=head1 SYNOPSIS

 npg_:warehouse::loader->new()->load;

=head1 DESCRIPTION


=head1 SUBROUTINES/METHODS

=cut

subtype __PACKAGE__.'::EAN13digits'
  => where { /\A\d{13}\z/smx }
  => as 'Int'
  => message { 'EAN13 barcode should be 13 digits' };

subtype __PACKAGE__.'::EAN13'
  => where {
             my@a=split '',$_;
             my$chk=pop @a;
             my$sum=0; my$odd=0;
             while(@a){my$v=pop@a; $sum+= (($odd^=1) ? 3 : 1) * $v; }
             $sum %= 10;
             if($sum) {$sum = 10 - $sum;}
             $chk==$sum
           }
  => as __PACKAGE__.'::EAN13digits'
  => message { "EAN13 barcode checksum fail for code $_" };

has tube_ean13_barcode => ( 'isa'    => __PACKAGE__.'::EAN13',
                            'is'     => 'ro',
);

has 'purpose' => (isa => 'Str', is => 'ro', default => 'qc');

has tube_barcode => (
  'isa'=> 'Int',
  'is' => 'ro',
  'lazy_build' => 1,
);
sub _build_tube_barcode{
  my($self)=@_;
  if(! $self->tube_ean13_barcode){
    croak 'Require EAN13 barcode to figure out barcode number';
  }
  my($barcode)=$self->tube_ean13_barcode=~/\d{3}(\d{7})\d{3}/sm;
  if($barcode){$barcode+=0;} #should be integer
  return $barcode
}

has 'position'    => ('isa'       => 'Maybe[NpgTrackingLaneNumber]',
                      'is'        => 'ro',
                      'default'   => undef,
                     );

has npg_warehouse_schema => (
  'isa' => 'npg_warehouse::Schema',
  'is'  => 'ro',
  'lazy_build' => 1,
);
sub _build_npg_warehouse_schema {return npg_warehouse::Schema->connect();}

has receptacle_id => (
  'is' => 'ro',
  'lazy_build' => 1,
);
sub _build_receptacle_id {
  my($self)=@_;
  if(! $self->tube_barcode){
    croak 'Require barcode to figure out receptacle';
  }
  my $rs = $self->npg_warehouse_schema->resultset('CurrentTube')->search({'barcode'=>$self->tube_barcode});
  if ($rs->count != 1) {
    croak 'Single tube not found from barcode '.($self->tube_barcode).' (Found '.($rs->count).($rs->count?join q( ),q(:),map{$_->name}$rs->all:q{}).')';
  }
  return $rs->next->internal_id;
}

=head2 BUILD

Post-constructor hook

=cut

sub BUILD {
  my($self)=@_;
  $self->receptacle_id;
  return;
}

has _aliquot_resultset => (
  'is' => 'ro',
  'lazy_build' => 1,
  'clearer' => 'free_children',
);
sub _build__aliquot_resultset {
  my($self)=@_;
  return  $self->npg_warehouse_schema->resultset('CurrentAliquot')->search({'receptacle_internal_id'=>$self->receptacle_id});
}

=head2 children

=cut

sub children {
  my($self)=@_;
  if($self->position){
    return $self->_aliquot_resultset>1 ? ($self->_aliquot_resultset->all) : ();
  }
  return ($self->meta->clone_object($self,'position'=>1));
}

#Add methods delegated to by lims shim if available in the aliquot resultset and we don't already have them
my $aliquot_meta = npg_warehouse::Schema::Result::CurrentAliquot->meta;
for my$m (grep { not __PACKAGE__->meta->has_method($_) } grep { $aliquot_meta->has_method($_) } st::api::lims->driver_method_list() ){
  __PACKAGE__->meta->add_method( $m, sub {my$self=shift; if($self->position and 1 == scalar $self->_aliquot_resultset){ return $self->_aliquot_resultset->first->$m } return; });
}

no Moose;
1;

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Carp

=item npg_warehouse::Schema

=item Moose

=item MooseX::StrictConstructor

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

David K Jackson <david.jackson@sanger.ac.uk>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2013 GRL, by David Jackson

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

