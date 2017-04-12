package Wardrobe::Helpers::ParamsValidation;

=head1 NAME

Wardrobe::Helpers::ParamsValidation - Methods to verify request params

=head1 DESCRIPTION

Specific subrutines to verify if parameters sent to request are correct

=cut

use strict;
use warnings;

use base qw( Exporter );
our @EXPORT_OK = qw( check_save_params );

use String::Util;

=head1 METHODS

=head2 check_save_params

Gets as arguments two hashes:
    i<$params> - that represents the request parameters 
and 
    i<$required_fields> that are the required parameters for the request

    If some of the request parameters is missing from the required parameters,
    the subrutine will return an error message(string)

=cut

sub check_save_params {
    my ( $params, $required_fields ) = @_;

    my @fields_with_errors;

    foreach my $required_field ( keys %$required_fields ) {
        if ( defined $params->{$required_field} && !String::Util::trim($params->{$required_field}) ) {
            push @fields_with_errors, $required_fields->{$required_field};
        }
    }

    if ( @fields_with_errors ) {
        return _build_error_message(\@fields_with_errors);
    }
}

=head2 _build_error_message

Private sub.

Expects an arrayref of strings. Based on that it will return a pretty error message

=cut

sub _build_error_message {
    my $pb_fields = shift;

    my $error_message = join( ' ',
        join(', ', @$pb_fields),
        @$pb_fields > 1 ? 'fields' : 'field',
        @$pb_fields > 1 ? 'are' : 'is',
        'empty'
    );

    return $error_message;
}

=head1 AUTHOR

Mirela Iclodean <imirela at cpan.org>

=head1 LICENSE

=cut

1;