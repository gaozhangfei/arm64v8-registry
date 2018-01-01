# Build a minimal distribution container

FROM arm64v8/alpine:3.7

RUN set -ex \
    && apk add --no-cache ca-certificates apache2-utils

COPY ./ld-2.24.so /lib
COPY ./aarch64-linux-gnu /lib
COPY ./registry/registry /bin/registry
COPY ./registry/config-example.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]
EXPOSE 5000

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/etc/docker/registry/config.yml"]
