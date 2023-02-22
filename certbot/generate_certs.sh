#!/bin/bash
HOSTNAMES=""

for host in $HOST_NAMES; do
	HOSTNAMES="$HOSTNAMES -d $host"
done

certonly \
    --dns-cloudflare \
    --dns-cloudflare-credentials /certs/cloudflare.ini \
    $HOSTNAMES \
	--config-dir /certs \
    --email $CF_EMAIL \
    --agree-tos \
    --server https://acme-v02.api.letsencrypt.org/directory
