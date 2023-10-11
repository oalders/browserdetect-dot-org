# browserdetect.org

This is a standalone web app which demonstrates how
[HTTP::BrowserDetect](https://metacpan.org/pod/HTTP::BrowserDetect) parses
arbitrary UserAgent strings.  Clone this repository and:

```text
cpm install -g --cpanfile cpanfile
perl bin/app.pl prefork --listen http://*:8001 --home "$PWD"
```

The deployed site is at <https://browserdetect.org>
