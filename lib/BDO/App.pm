package BDO::App;

use strict;
use warnings;

use Plack::Builder qw( builder enable mount );

sub to_app {
    my $app = builder {
        enable 'Plack::Middleware::Static',
            path => qr{^/(css|fonts|js)/},
            root => './static/';
        mount '/' => builder {
            require 'bin/app.pl';
        };
    };

    return $app;
}

1;

=pod

=head1 DESCRIPTION

This file exists solely for wrapping the app with middleware.

=cut
