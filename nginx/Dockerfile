FROM nginx:1.20.1-alpine@sha256:2012644549052fa07c43b0d19f320c871a25e105d0b23e33645e4f1bcf8fcd97 AS base

RUN rm /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

FROM base AS prod

FROM base AS dev

CMD nginx -g 'daemon off;'
