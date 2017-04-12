package Wardrobe::Routes::Cloths;

use Dancer2 appname => 'Wardrobe'; 

use Dancer2::Plugin::DBIC;
use Dancer2::Plugin::Deferred;

use Wardrobe::Helpers::ParamsValidation qw( check_save_params );

=head1 NAME

Wardrobe::Routes::Cloth - Dancer routes for clothes management

=head1 DESCRIPTION

Specific routes manage clothes in wardrobe

=cut

prefix '/cloth' => sub {
    get '/add' => sub {
        my $wardrobe_schema = schema 'wardrobe';
        my @outfits = $wardrobe_schema->resultset('Outfit')->search(undef, { order_by => 'id' });

        template 'cloth/add', {
            title   => 'Add Cloth',
            outfits => \@outfits,
        };
    };

    get '/edit' => sub {
        my $wardrobe_schema = schema 'wardrobe';
        my $cloth = $wardrobe_schema->resultset('Cloth')->find(params->{id});

        my @outfits = $wardrobe_schema->resultset('Outfit')->search();

        template 'cloth/add', {
            title   => 'Add Cloth',
            cloth   => $cloth,
            outfits => \@outfits,
            existing_outfits => { map { $_->id => 1 } $cloth->outfits() },
        };
    };

    post '/save' => sub {
        my $params = params;

        # Check if params are defined
        my $required_fields = {
            id   => 'id',
            name => 'Name',             
        };

        my $error_message = check_save_params($params, $required_fields);

        if ( $error_message ) {
            deferred error => $error_message;

            redirect request->referer;
        }

        my $outfit_ids = delete $params->{outfit};

        my $wardrobe_schema = schema 'wardrobe';
        my $cloth = $wardrobe_schema->resultset('Cloth')->update_or_create($params);        

        # Add to outfits
        my @outfits = $wardrobe_schema->resultset('Outfit')->search(id => $outfit_ids); 

        $cloth->set_outfits(\@outfits);

        redirect '/';
    };

    get '/delete' => sub {
        my $params = params;
        my $id = delete $params->{id};

        if ($id) {
            my $wardrobe_schema = schema 'wardrobe';
            my $cloth = $wardrobe_schema->resultset('Cloth')->find($id)->delete();  
        }      

        redirect '/';
    };
};

=head1 AUTHOR

Mirela Iclodean <imirela at cpan.org>

=head1 LICENSE

=cut

1;
