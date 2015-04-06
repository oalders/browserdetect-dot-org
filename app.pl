#!/usr/bin/env perl

use Mojolicious::Lite;

use HTTP::BrowserDetect;

# Route with placeholder
get '/' => sub {
    my $c      = shift;
    my $ua     = $c->req->param( 'ua' ) || $c->req->env->{HTTP_USER_AGENT};
    my $parser = HTTP::BrowserDetect->new( $ua );
    $c->stash( parser => $parser, ua => $ua );
    return $c->render;

} => 'index';

app->start;
__DATA__

@@ index.html.ep
% layout 'default';

<p>Parsing UserAgent: <%= $ua %></p>

Browser: <%= $parser->browser_string %>
Version: <%= $parser->browser_version %>

<ul>
  % for my $p ($parser->browser_properties) {
    <li>
      %= $p
    </li>
  % }
</ul>

%= form_for '/' => begin
  %= text_field ua => $ua
  %= submit_button
% end

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title>BrowserDetect.org</title></head>
  <body><%= content %></body>
</html>
