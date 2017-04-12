package Wardrobe;

use Dancer2 ':syntax';

our $VERSION = '0.1';

use Dancer2::Plugin::DBIC;

# Load routes
use Wardrobe::Routes::Cloths;
use Wardrobe::Routes::Outfits;

=head1 NAME

Wardrobe - Dancer routes for clothes and outfits management

=head1 DESCRIPTION

Include all the routes for clothes and outfit management. 
Also it has a search route, that will search clothes by name in the wardrobe


=cut

get '/' => sub {
    my $wardrobe_schema = schema 'wardrobe';

    my @clothes = $wardrobe_schema->resultset('Cloth')->search();

    template 'index', {
        clothes => \@clothes,
    };
};

post '/search' => sub {
    my $query = params->{query};

    redirect '/'
        unless $query;

    my $results;

    if (length $query) {
        $results = _get_cloth_by_name($query);
    }

    template 'index', { 
        query   => $query,
        clothes => $results,
    };
};

=head1 METHODS

=head2 _get_cloth_by_name

Arguments: <$query> : string
Retrieves from DB clothes whose name contain the string sent as a parameter

=cut

sub _get_cloth_by_name {
    my $query = shift();

    my $wardrobe_schema = schema 'wardrobe';

    my @clothes = $wardrobe_schema->resultset('Cloth')
        ->search({
            name => { like => "%$query%" },
        });

    return \@clothes;
}


=head1 AUTHOR

Mirela Iclodean <imirela at cpan.org>

=head1 LICENSE

=cut

1;
