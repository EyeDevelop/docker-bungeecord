FROM openjdk:8-alpine

RUN apk add -U su-exec bash curl git
COPY server/entrypoint.sh /entrypoint.sh

ENV PUID 1000
ENV PGID 1000
ENV MC_VERSION=1.16.4
ENV MEMORY_USAGE 1024M

CMD ["/entrypoint.sh"]
