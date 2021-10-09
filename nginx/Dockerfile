FROM nginx:1.20.1-alpine@sha256:2012644549052fa07c43b0d19f320c871a25e105d0b23e33645e4f1bcf8fcd97 AS base

COPY nginx.conf.template /etc/nginx/nginx.conf.template
CMD envsubst </etc/nginx/nginx.conf.template> /etc/nginx/nginx.conf && nginx -g 'daemon off;'

FROM base AS prod
ARG SERVER_HOST
RUN apk add openssl && \
    openssl req -x509 -nodes -days 3650 \
    -subj "/C=AM/ST=Yerevan/L=Armenia/O=selfsigned/CN=selfsigned" \
    -addext "subjectAltName=DNS:${SERVER_HOST}" \
    -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt;

FROM base AS dev
ARG SERVER_HOST
RUN apk add openssl && \
    openssl req -x509 -nodes -days 3650 \
    -subj "/C=AM/ST=Yerevan/L=Armenia/O=selfsigned/CN=selfsigned" \
    -addext "subjectAltName=DNS:${SERVER_HOST}" \
    -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt;
