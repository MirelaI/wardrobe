use strict;
use warnings;

my $db_user = shift;
my $db_pass = shift;

die "Please provide database credentials!"
    unless ( $db_user && $db_pass );

use DBIx::Class::Schema::Loader qw/ make_schema_at /;

make_schema_at(
    'Wardrobe::Model::Schema',
    { 
        debug => 1,
        dump_directory => '../lib',
        moniker_map => {
                clothes           => 'Cloth',
                clothes_tags      => 'ClothTag',
            },
    },
    [ 
        'dbi:mysql:wardrobe:localhost=', $db_user, $db_pass,
        #{ loader_class => 'MyLoader' } # optionally
    ],
);