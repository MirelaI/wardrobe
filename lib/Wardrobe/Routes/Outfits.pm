package Wardrobe::Routes::Outfits;

use Dancer2 appname => 'Wardrobe'; 

use Dancer2::Plugin::DBIC;

use Wardrobe::Helpers::ParamsValidation qw( check_save_params );

=head1 NAME

Wardrobe::Routes::Outfits - Dancer routes for outfits management

=head1 DESCRIPTION

Specific routes manage outfits in wardrobe

=cut

prefix '/outfits' => sub {
    get '/' => sub {
        my $wardrobe_schema = schema 'wardrobe';

        my @outfits = $wardrobe_schema->resultset('Outfit')->search();

        template '/outfits/index', {
            outfits => \@outfits,
        };
    };

    get '/view' => sub {
        my $wardrobe_schema = schema 'wardrobe';
        my $id = delete params->{id};

        redirect '/' unless $id;

        my $outfit = $wardrobe_schema->resultset('Outfit')->find( $id );

        template '/outfits/view', {
            outfit => $outfit,
        };
    };

    get '/add' => sub {
        my $wardrobe_schema = schema 'wardrobe';

        my @clothes = $wardrobe_schema->resultset('Cloth')->search();

        template 'outfits/add', {
            title     => 'Add Outfit',
            clothes   => \@clothes,
        };
    };

    get '/edit' => sub {

        my $wardrobe_schema = schema 'wardrobe';
        my $outfit = $wardrobe_schema->resultset('Outfit')->find(params->{id});

        my @clothes = $wardrobe_schema->resultset('Cloth')->search();

        template 'outfits/add', {
            title   => 'Edit Cloth',
            outfit  => $outfit,
            clothes => \@clothes,
            existing_clothes => { map { $_->id => 1 } $outfit->clothes() },
        };
    };

    post '/save' => sub {
        my $params = params;
        my $clothes_ids = delete $params->{cloth};

        # Check if params are defined
        # TODO:
        # Shoult be the same validation as in Clothes/save
        # but for some reason Dancer2::Plugin::Deferred;
        # has some weird behaviour .... no time to investigate this now;
        my $required_fields = {
            id   => 'id',
            tag  => 'Name',             
        };

        my $error_message = check_save_params($params, $required_fields);

        if ( $error_message ) {
            status error => $error_message;

            redirect request->referer;
        }

        my $wardrobe_schema = schema 'wardrobe';
        my $outfit = $wardrobe_schema->resultset('Outfit')->update_or_create($params);        

        # Add clothes
        my @clothes = $wardrobe_schema->resultset('Cloth')->search( id => $clothes_ids); 

        $outfit->set_clothes(\@clothes);

        redirect 'outfits';
    };

    get '/delete' => sub {
        my $params = params;
        my $id = delete $params->{id};

        my $wardrobe_schema = schema 'wardrobe';
        my $cloth = $wardrobe_schema->resultset('Outfit')->find($id)->delete();        

        redirect 'outfits';
    };
};


=head1 AUTHOR

Mirela Iclodean <imirela at cpan.org>

=head1 LICENSE

=cut

1;
