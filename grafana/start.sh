#! /bin/bash

#cat config.js | sed -e "s/@@ELS_HOST@@/$ELS_PORT_9200_TCP_ADDR/"\
#  -e "s/@@ELS_PORT@@/$ELS_PORT_9200_TCP_PORT/" \
#  -e "s/@@GRAPHITE_HOST@@/$GRAPHITE_PORT_80_TCP_ADDR/" \
#  -e "s/@@GRAPHITE_PORT@@/$GRAPHITE_PORT_80_TCP_PORT/" \
#  > grafana/config.js

cat /grafana/apache-grafana.conf | sed  -e "s#@@GRAPHITE_HOST@@#${GRAPHITE_PORT_80_TCP_ADDR}:${GRAPHITE_PORT_80_TCP_PORT}/#" \
  -e "s#@@ELS_HOST@@#${ELS_PORT_9002_TCP_ADDR}:${ELS_PORT_9002_TCP_PORT}/#"\
  > /etc/apache2/sites-available/grafana.conf
sudo a2ensite grafana

cat config.js | sed -e "s#@@ELS_HOST@@#${IP_EXPOSE}/graphite#" \
  -e "s#@@GRAPHITE_HOST@@#${IP_EXPOSE}:${PORT_EXPOSE}/graphite/#" \
  > grafana/config.js

#lighttpd -Df /etc/lighttpd/lighttpd.conf
/usr/bin/supervisord