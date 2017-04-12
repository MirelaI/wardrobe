use utf8;
package Wardrobe::Model::Schema::Result::ClothTag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Wardrobe::Model::Schema::Result::ClothTag

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<clothes_tags>

=cut

__PACKAGE__->table("clothes_tags");

=head1 ACCESSORS

=head2 cloth_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 tag_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "cloth_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "tag_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 RELATIONS

=head2 cloth

Type: belongs_to

Related object: L<Wardrobe::Model::Schema::Result::Cloth>

=cut

__PACKAGE__->belongs_to(
  "cloth",
  "Wardrobe::Model::Schema::Result::Cloth",
  { id => "cloth_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 tag

Type: belongs_to

Related object: L<Wardrobe::Model::Schema::Result::Outfit>

=cut

__PACKAGE__->belongs_to(
  "tag",
  "Wardrobe::Model::Schema::Result::Outfit",
  { id => "tag_id" },
  { is_deferrable => 1, on_delete => "ALLOW", on_update => "ALLOW" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-10-30 16:41:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0OdtFx+ej9nCTBNyO21SPw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
