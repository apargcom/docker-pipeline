FROM nginx:1.20.1-alpine@sha256:2012644549052fa07c43b0d19f320c871a25e105d0b23e33645e4f1bcf8fcd97 AS base

COPY nginx.conf.template /etc/nginx/nginx.conf.template
CMD envsubst '${APP_PORT} ${SERVER_HOST}' \
    </etc/nginx/nginx.conf.template> /etc/nginx/nginx.conf && \
    nginx -g 'daemon off;'

FROM base AS prod
#TODO: Add lets encrypt with 90 days autorenewal for production
RUN apk add openssl && \
    openssl req -x509 -nodes -days 3650 \
    -subj "/C=AM/ST=Yerevan/L=Armenia/O=selfsigned/CN=selfsigned" \
    -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt;

FROM base AS dev
RUN apk add openssl && \
    openssl req -x509 -nodes -days 3650 \
    -subj "/C=AM/ST=Yerevan/L=Armenia/O=selfsigned/CN=selfsigned" \
    -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt;
