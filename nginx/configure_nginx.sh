#!/bin/bash

for env in $(printenv); do
	[[ ${env//[[:space:]]/} =~ ^#.* || -z "$env" ]] && continue
		echo $env | tr "=" "\n" | while read -r key; do
			if [[ "$key" == *"DOMAIN"* ]]; then
   				read -r value
				options="$(echo $value | tr ":" "\n")"
				domain=$(echo $options | awk -v N=1 '{print $N}')
				port=$(echo $options | awk -v N=2 '{print $N}')
				app_name=$(echo $options | awk -v N=3 '{print $N}')
				file_path="/etc/nginx/conf.d/$domain.conf"

				cp default.conf $file_path
				sed -i "s/default_server/$domain/g" $file_path
				sed -i "s/app_name/$app_name/g" $file_path
				sed -i "s/app_port/$port/g" $file_path
			fi
   		done
done

nginx -s reload
