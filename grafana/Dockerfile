FROM ubuntu:latest
MAINTAINER Jean-Pascal THIERY <jean-pascal@thiery.in>

RUN sudo apt-get update && sudo apt-get install -y apache2 supervisor && sudo apt-get clean

ADD current /grafana
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf
ADD grafana.conf /grafana/apache-grafana.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN sudo a2dissite 000-default && sudo a2enmod headers && sudo a2enmod proxy_http && mkdir -p /grafana/logs/apache && chmod -R 777 /grafana
ADD config.js config.js

ADD start.sh start.sh
RUN chmod +x start.sh

EXPOSE 80

VOLUME conf

ENTRYPOINT  /start.sh