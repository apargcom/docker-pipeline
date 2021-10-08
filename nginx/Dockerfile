FROM nginx:1.20.1-alpine@sha256:2012644549052fa07c43b0d19f320c871a25e105d0b23e33645e4f1bcf8fcd97

WORKDIR /etc/nginx
COPY nginx.conf.template ./nginx.conf.template
CMD envsubst <./nginx.conf.template> ./nginx.conf && nginx -g 'daemon off;'