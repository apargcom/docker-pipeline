FROM nginx:1.20.1-alpine@sha256:2012644549052fa07c43b0d19f320c871a25e105d0b23e33645e4f1bcf8fcd97 AS base

COPY nginx.conf.template /etc/nginx/nginx.conf.template
#Replace all env variables without touching nginx internal variables


FROM base AS prod
RUN apk add openssl && openssl req -x509 -nodes -days 3650 -subj "/C=AM/ST=Yerevan/L=Armenia/O=selfsigned/CN=selfsigned" -newkey rsa:2048 -keyout /etc/ssl/private/privkey.pem -out /etc/ssl/certs/fullchain.pem
ARG SERVER_HOST ADMIN_EMAIL
#TODO: Test on real server - lets encrypt with 90 days autorenewal for production
RUN apk add --no-cache certbot && \
    echo -e "#!/bin/sh\npython3 -c 'import random; import time; time.sleep(random.random() * 3600)' &&  certbot renew --webroot --webroot-path /var/lib/certbot/ --post-hook '/usr/sbin/nginx -s reload'" >> /etc/periodic/daily/renew_ssl && \
    chmod +x /etc/periodic/daily/renew_ssl && \
    mkdir /var/lib/certbot
#TODO: Change last ';' certbot generation line to '&&' on production
CMD envsubst "$(printf '${%s} ' $(env|cut -d'=' -f1))" </etc/nginx/nginx.conf.template> /etc/nginx/nginx.conf && \    
    certbot certonly --standalone -d ${SERVER_HOST},www.${SERVER_HOST} --email ${ADMIN_EMAIL} -n --agree-tos --expand ; \
    crond -f -d 8 & \ 
    nginx -g 'daemon off;'

FROM base AS dev

RUN apk add openssl && \
    openssl req -x509 -nodes -days 3650 \
    -subj "/C=AM/ST=Yerevan/L=Armenia/O=selfsigned/CN=selfsigned" \
    -newkey rsa:2048 -keyout /etc/letsencrypt/live/privkey.pem \
    -out /etc/letsencrypt/live/fullchain.pem
CMD envsubst "$(printf '${%s} ' $(env|cut -d'=' -f1))" </etc/nginx/nginx.conf.template> /etc/nginx/nginx.conf && \
    nginx -g 'daemon off;'
