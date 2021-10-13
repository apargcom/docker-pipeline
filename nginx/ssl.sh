#!/bin/sh

function openssl_build(){

    apk add openssl
}

function openssl_start(){
    
    mkdir -p /etc/letsencrypt/live/${SERVER_HOST} && \    
    openssl req -x509 -nodes -days 3650 \
    -subj "/C=AM/ST=Yerevan/L=Armenia/O=selfsigned/CN=selfsigned" -addext "subjectAltName=DNS:${SERVER_HOST}" \
    -newkey rsa:2048 -keyout /etc/letsencrypt/live/${SERVER_HOST}/privkey.pem \
    -out /etc/letsencrypt/live/${SERVER_HOST}/fullchain.pem && \
    chmod -R +rw /etc/letsencrypt/live/${SERVER_HOST}
}

function certbot_build(){
    
    apk add --no-cache certbot && \
    echo -e "#!/bin/sh\npython3 -c 'import random; import time; time.sleep(random.random() * 3600)' && \\
        certbot renew --webroot --webroot-path /var/lib/certbot/ --post-hook '/usr/sbin/nginx -s reload'" >> /etc/periodic/daily/renew_ssl && \
    chmod +x /etc/periodic/daily/renew_ssl && \
    mkdir /var/lib/certbot
}

function certbot_start(){

    certbot certonly --standalone -d ${SERVER_HOST},www.${SERVER_HOST} --email ${ADMIN_EMAIL} -n --agree-tos --expand && \
    crond -f -d 8 &
}

while true; do
  case "$1" in
    -t | --type ) STAGE_TYPE="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ "${SSL_TYPE}" == "certbot" ]
then
	if [ "${STAGE_TYPE}" == "build" ]
    then
        certbot_build
    elif [ "${STAGE_TYPE}" == "start" ]
    then
        certbot_start
    fi
elif [ "${SSL_TYPE}" == "openssl" ]
then
    if [ "${STAGE_TYPE}" == "build" ]
    then
        openssl_build
    elif [ "${STAGE_TYPE}" == "start" ]
    then
        openssl_start
    fi
fi