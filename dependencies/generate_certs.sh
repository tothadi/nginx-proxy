#!/bin/bash -v

HOSTNAMES=""

for host in $HOST_NAMES; do
	HOSTNAMES="$HOSTNAMES -d $host"
done

certbot certonly \
    --dns-cloudflare \
    --dns-cloudflare-credentials /dependencies/cloudflare.ini \
    $HOSTNAMES \
	--config-dir /etc/nginx/certs \
    --email $CF_EMAIL \
    --agree-tos \
    --server https://acme-v02.api.letsencrypt.org/directory
