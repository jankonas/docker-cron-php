FROM alpine:latest

### cron

ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=048b95b48b708983effb2e5c935a1ef8483d9e3e

# install dependencies
RUN apk add --update --no-cache ca-certificates curl \
# install supercronic
    && curl -fsSLO "$SUPERCRONIC_URL" \
    && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
    && chmod +x "$SUPERCRONIC" \
    && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
    && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic \
# remove unwanted deps & cleanup
    && apk del --purge ca-certificates curl \
    && rm -rf /tmp/* /var/cache/apk/*

COPY crontab /etc/crontabs/crontab

### php handling

RUN apk add --update --no-cache fcgi
COPY php-console.sh /usr/local/bin/php-console
RUN chmod +x /usr/local/bin/php-console

### startup

ENTRYPOINT ["supercronic"]
CMD ["/etc/crontabs/crontab"]
