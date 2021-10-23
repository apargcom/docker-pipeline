#!/bin/sh

function openssl_build(){

    apk add openssl
}

function openssl_start(){
    
    mkdir -p /etc/letsencrypt/live/$HOST
    openssl req -x509 -nodes -days 3650 \
    -subj "/C=AM/ST=Yerevan/L=Armenia/O=Selfsigned/CN=$HOST" -addext "subjectAltName=DNS:$HOST" \
    -newkey rsa:2048 -keyout /etc/letsencrypt/live/$HOST/privkey.pem \
    -out /etc/letsencrypt/live/$HOST/fullchain.pem
}

function certbot_build(){
    
    apk add --no-cache certbot
    echo -e "#!/bin/sh\npython3 -c 'import random; import time; time.sleep(random.random() * 3600)' && \\
        certbot renew --webroot --webroot-path /var/lib/certbot/ --post-hook \"/usr/sbin/nginx -s reload\"" >> /etc/periodic/daily/renew_ssl && \
    chmod +x /etc/periodic/daily/renew_ssl
    mkdir /var/lib/certbot
}

function certbot_start(){

    certbot certonly --standalone -d $HOST,www.$HOST --email $EMAIL -n --agree-tos --expand
    crond -f -d 8 &
}

while true; do
  case "$1" in
    -s | --ssl ) SSL="$2"; shift 2 ;;
    -h | --host ) HOST="$2"; shift 2 ;;
    -t | --type ) TYPE="$2"; shift 2 ;;
    -e | --email ) EMAIL="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ "$SSL" == "certbot" ]
then
	if [ "$TYPE" == "build" ]
    then
        certbot_build
    elif [ "$TYPE" == "start" ]
    then
        certbot_start
    fi
elif [ "$SSL" == "openssl" ]
then
    if [ "$TYPE" == "build" ]
    then
        openssl_build
    elif [ "$TYPE" == "start" ]
    then
        openssl_start
    fi
fi