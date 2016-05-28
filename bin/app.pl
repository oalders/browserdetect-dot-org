#!/usr/bin/env perl

use Mojolicious::Lite;
use Mojo::Util qw(url_escape);

use HTTP::BrowserDetect;

# Route with placeholder
get '/' => sub {
    my $c       = shift;
    my $ua      = $c->req->param('ua') || $c->req->env->{HTTP_USER_AGENT};
    my $parser  = HTTP::BrowserDetect->new($ua);
    my @methods = (
        'browser_string',
        'browser_version',
        'engine',
        'engine_version',
        'os_string',
        'os_version',
        'device_string',
        'country',
        'language',
    );

    $c->stash(
        show_link => !$c->req->param('ua'),
        methods   => \@methods,
        parser    => $parser,
        version   => $HTTP::BrowserDetect::VERSION,
    );
    return $c->render;

} => 'index';

app->start;
__DATA__

@@ index.html.ep
% layout 'default';

<table class="table table-bordered text-left">
  <tr>
    <td colspan="2" class="align-middle"><%= $parser->user_agent %><% if ($show_link) { %> <a href="<%= url_for('/')->query(ua => $parser->user_agent) %>"><i class="glyphicon glyphicon-link"></i></a><% } %></td>
  </tr>

  % for my $method (@{$methods} ){
  %    if ( $parser->$method ) {
    <tr>
      <td><%= $method %></td>
      <td><%= $parser->$method %></td>
    </tr>
  %    }
  % }

  % for my $method ('mobile','tablet','robot') {
    <tr>
      <td><%= $method %></td>
      <td><%= $parser->$method ? 'Yes' : 'No'  %></td>
    </tr>
  % }


</table>

<form class="form-inline" action="/" method="get">
  <div class="form-group">
    <input type="text" class="form-control" placeholder="Parse UserAgent string" name="ua" />
    <button type="submit" class="btn btn-default">Submit</button>
  </div>
</form>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/favicon.ico">

    <title>BrowserDetect.org</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/cover.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="site-wrapper">

      <div class="site-wrapper-inner">

        <div class="cover-container">

          <div class="masthead clearfix">
            <div class="inner">
              <h3 class="masthead-brand"><a href="<%= url_for('/') %>">browser detect dot org</a></h3>
              <nav>
                <ul class="nav masthead-nav">
                  <li><a href="https://github.com/oalders/http-browserdetect">Fork HTTP::BrowserDetect</a></li>
                  <li><a href="https://github.com/oalders/browserdetect-dot-org">Fork this site</a></li>
                </ul>
              </nav>
            </div>
          </div>

          <div class="inner cover">
            <h1 class="cover-heading">&nbsp;</h1>
            <%= content %>
          </div>

          <div class="mastfoot">
            <div class="inner">
              <p>
                Powered by <a href="https://metacpan.org/release/OALDERS/HTTP-BrowserDetect-<%= $version %>">HTTP::BrowserDetect <%= $version %></a> |
                Site by <a href="https://twitter.com/olafalders">@olafalders</a> |
                Cover template by <a href="https://twitter.com/mdo">@mdo</a>.</p>
            </div>
          </div>

        </div>

      </div>

    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
