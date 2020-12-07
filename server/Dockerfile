FROM openjdk:8-alpine

RUN apk add -U su-exec bash curl git
COPY server/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
