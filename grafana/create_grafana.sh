#!/bin/bash

function usage() {
  SCRIP=$(basename $0)
  echo "Usage :$SCRIPT IP_EXPOSE GRAFANA_PORT <GRAPHITE_PORT>"
}


# Thanks : http://www.linuxjournal.com/content/validating-ip-address-bash-script
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

if [[ -z $1 ]]; then 
  usage
  exit 1
else
  if valid_ip $1; then
    echo "Launching grafana expose on ip $1"
  else
    echo "$1 isn't a valid Ip"
    usage 
    exit 1 
  fi
fi

if [[ -z $2 ]]; then 
  usage
  exit 1
fi


IP_EXPOSE=$1
PORT_EXPOSE=$2
if [[ -z $3 ]]; then
  GRAPHITE_PORT_EXPOSE="-P"
else
  GRAPHITE_PORT_EXPOSE="-p $3:2003 -P"
fi

REGISTRY=""

GRAPHITE_IMAGE="${REGISTRY}jpthiery/graphite"
GRAFANA_IMAGE="${REGISTRY}jpthiery/grafana"
ELS_IMAGE="dockerfile/elasticsearch"

ELS_ID=$(docker run -d -P $ELS_IMAGE)
ELS_NAME=$(docker inspect -f '{{.Name}}' $ELS_ID)

GRAPHITE_ID=$(docker run -d $GRAPHITE_PORT_EXPOSE $GRAPHITE_IMAGE)
GRAPHITE_NAME=$(docker inspect -f '{{.Name}}' $GRAPHITE_ID)
echo "docker run -d -P --link $ELS_NAME:els --link $GRAPHITE_NAME:graphite -e "IP_EXPOSE=$IP_EXPOSE" $GRAFANA_IMAGE"
GRAFANA_ID=$(docker run -d -p $PORT_EXPOSE:80 --link ${ELS_NAME:1}:els --link ${GRAPHITE_NAME:1}:graphite -e "IP_EXPOSE=$IP_EXPOSE" -e "PORT_EXPOSE=$PORT_EXPOSE" $GRAFANA_IMAGE)
GRAFANA_NAME=$(docker inspect -f '{{.Name}}' $GRAFANA_ID)
GRAFANA_PORT=$(docker port $GRAFANA_ID 80/tcp | awk -F ':' '{print $2}')

echo "Grafana container $GRAFANA_NAME [$GRAFANA_ID] could be acces via htt://$IP_EXPOSE:$GRAFANA_PORT "

exit 0
