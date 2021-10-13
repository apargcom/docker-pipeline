FROM nginx:1.20.1-alpine@sha256:2012644549052fa07c43b0d19f320c871a25e105d0b23e33645e4f1bcf8fcd97

ARG SERVER_HOST ADMIN_EMAIL SSL_TYPE
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY ssl.sh /ssl.sh
RUN chmod +x /ssl.sh && \
    /ssl.sh --ssl ${SSL_TYPE} --host ${SERVER_HOST} --type build
CMD /ssl.sh --ssl ${SSL_TYPE} --host ${SERVER_HOST} --type start && \
    envsubst "$(printf '${%s} ' $(env|cut -d'=' -f1))" </etc/nginx/nginx.conf.template> /etc/nginx/nginx.conf && \
    nginx -g 'daemon off;'