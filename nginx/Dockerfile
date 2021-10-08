FROM nginx:1.20.1-alpine@sha256:2012644549052fa07c43b0d19f320c871a25e105d0b23e33645e4f1bcf8fcd97 AS base

COPY nginx.conf.template /etc/nginx/nginx.conf.template
CMD envsubst </etc/nginx/nginx.conf.template> /etc/nginx/nginx.conf && nginx -g 'daemon off;'