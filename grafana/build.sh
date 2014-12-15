#! /bin/bash

VERSION=1.8.1
DL_URL="http://grafanarel.s3.amazonaws.com/grafana-$VERSION.tar.gz"

rm -f current 2> /dev/null
mkdir -p current


curl -o grafana.tar.gz $DL_URL
tar -xvzf grafana.tar.gz 
mv grafana-*/* current

docker build -t="jpthiery/grafana" .