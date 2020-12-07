FROM openjdk:8-alpine

RUN apk add -U su-exec bash curl
COPY proxy/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
