#!/bin/bash -v

for item in $(echo $DOMAINS | tr "/" "\n" ); do
	options="$(echo $item | tr ":" "\n")"
	domain=$(echo $options | awk -v N=1 '{print $N}')
	port=$(echo $options | awk -v N=2 '{print $N}')
	app_name=$(echo $options | awk -v N=3 '{print $N}')
	file_path="/etc/nginx/conf.d/$domain.conf"
	echo $file_path
	cp /dependencies/default.conf $file_path
	sed -i "s/default_server/$domain/g" $file_path
	sed -i "s/app_name/$app_name/g" $file_path
	sed -i "s/app_port/$port/g" $file_path
done

echo dns_cloudflare_email=$CF_EMAIL > /dependencies/cloudflare.ini
echo dns_cloudflare_api_key=$CF_API_KEY >> /dependencies/cloudflare.ini

chmod 600 /dependencies/cloudflare.ini

# /dependencies/generate_certs.sh 

crontab /dependencies/crontab
cron -f &
