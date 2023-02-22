#!/bin/bash -v

HOSTNAMES=""

for host in $HOST_NAMES; do
	certbot certonly \
    --dns-cloudflare \
    --dns-cloudflare-credentials /dependencies/cloudflare.ini \
    -d $host \
	--config-dir /etc/nginx/certs \
    --email $CF_EMAIL \
    --agree-tos \
    --server https://acme-v02.api.letsencrypt.org/directory
done
