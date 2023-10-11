FROM perl:5.36

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY . /app

WORKDIR /app

RUN cpanm --notest App::cpm && \ 
    cpm install -g Carton::Snapshot && \
    cpm install -g ${CPM_ARGS} --cpanfile cpanfile
#RUN rm -fr /root/.cpanm /root/.perl-cpm /tmp/*

EXPOSE 8001

CMD ["perl", "bin/app.pl", "prefork", "--listen", "http://*:8001", "--home", "/app"]
