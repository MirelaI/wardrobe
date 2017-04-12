package Wardrobe::Model::Schema;
use base qw(DBIx::Class::Schema::Loader);

package main;

use strict;
use warnings;

use Text::CSV;
use String::Util;

my $file_name = shift
    or die "You need to provide a file name\n";

my $db_user     = shift;
my $db_password = shift;

die "Please provide database credentials!"
    unless ( $db_user && $db_password );

open my $fh, "<:encoding(utf8)", $file_name or die sprintf("$file_name: $!");

my $csv = Text::CSV->new({ sep_char => ',' })
    or die sprintf ("Cannot use CSV: %s", Text::CSV->error_diag());

my @data;

while ( my $line = <$fh> ) {
    chomp $line;

    if ( $csv->parse($line) ) {
        my @values = $csv->fields();

        # cleanup leading and trailing spaces
        @values = map { String::Util::trim($_) } @values;

        push @data, \@values;
    } else {
        die sprinf("%s could not be parsed!", $line);
    }

}

my $schema = Wardrobe::Model::Schema->connect(
    {
        dsn         => 'dbi:mysql:wardrobe',
        user        => $db_user,
        password    => $db_password,
    }
);

$schema->populate('Clothes', \@data);