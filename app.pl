#!/usr/bin/env perl

use Mojolicious::Lite;

use HTTP::BrowserDetect;

# Route with placeholder
get '/' => sub {
    my $c      = shift;
    my $ua     = $c->req->param( 'ua' ) || $c->req->env->{HTTP_USER_AGENT};
    my $parser = HTTP::BrowserDetect->new( $ua );
    $c->stash( parser => $parser );
    return $c->render;

} => 'index';

app->start;
__DATA__

@@ index.html.ep
% layout 'default';

<table class="table table-bordered text-left">
  <tr>
    <td colspan="2" class="align-middle"><%= $parser->user_agent %></td>
  </tr>
  <tr>
    <td>Browser</td>
    <td><%= $parser->browser_string %></td>
  </tr>
  <tr>
    <td>Browser Version</td>
    <td><%= $parser->browser_version %></td>
  </tr>

  <tr>
    <td>Engine</td>
    <td><%= $parser->engine_string %></td>
  </tr>
  <tr>
    <td>Engine Version</td>
    <td><%= $parser->engine_version %></td>
  </tr>

  <tr>
    <td>OS</td>
    <td><%= $parser->os_string %></td>
  </tr>
  <tr>
    <td>OS Version</td>
    <td><%= $parser->os_version %></td>
  </tr>

  % for my $method ('mobile','tablet','device','robot') {
    <tr>
      <td><%= ucfirst $method %></td>
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
              <h3 class="masthead-brand">browser detect dot org</h3>
              <nav>
                <ul class="nav masthead-nav">
                  <li class="active"><a href="#">Home</a></li>
                  <li><a href="#">Fork on GitHub</a></li>
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
              <p>Cover template for <a href="http://getbootstrap.com">Bootstrap</a>, by <a href="https://twitter.com/mdo">@mdo</a>.</p>
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
