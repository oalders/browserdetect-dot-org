FROM perl:5.36

WORKDIR /app
COPY . .
RUN cpanm --notest App::cpm Carton::Snapshot \
    && cpm install -g \
    --show-build-log-on-failure \
    --workers $(grep -c ^processor /proc/cpuinfo) \
    --mirror https://cpan.metacpan.org \
    --cpanfile cpanfile

CMD ["perl", "bin/app.pl", "prefork"]
