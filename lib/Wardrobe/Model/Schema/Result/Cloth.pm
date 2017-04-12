use utf8;
package Wardrobe::Model::Schema::Result::Cloth;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Wardrobe::Model::Schema::Result::Cloth

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<clothes>

=cut

__PACKAGE__->table("clothes");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 category

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "category",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 clothes_tags

Type: has_many

Related object: L<Wardrobe::Model::Schema::Result::ClothTag>

=cut

__PACKAGE__->has_many(
  "clothes_tags",
  "Wardrobe::Model::Schema::Result::ClothTag",
  { "foreign.cloth_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 outfits

Type: many_to_many

Related object: L<Wardrobe::Model::Schema::Result::ClothTag>
L<Wardrobe::Model::Schema::Result::Cloth>

=cut

__PACKAGE__->many_to_many('outfits' => 'clothes_tags', 'tag');


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-10-30 16:41:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AZ8hC/+ZVsVSCuTCxP3qBA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
