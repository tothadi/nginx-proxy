FROM nginx:latest

RUN apt-get update && apt-get install -y cron python3-certbot-dns-cloudflare

RUN mkdir /dependencies
RUN mkdir /etc/nginx/certs

COPY ./dependencies/config.sh /docker-entrypoint.d/
COPY ./dependencies/generate_certs.sh /dependencies/
COPY ./dependencies/default.conf /dependencies/
COPY ./dependencies/crontab /dependencies/
