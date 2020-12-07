FROM openjdk:8-alpine

RUN apk add -U su-exec bash curl
COPY proxy/entrypoint.sh /entrypoint.sh

ENV PUID 1000
ENV PGID 1000
ENV BC_VERSION 1539
ENV MEMORY_USAGE 512M

CMD ["/entrypoint.sh"]
