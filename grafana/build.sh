#! /bin/bash

VERSION=1.9.0
DL_URL="http://grafanarel.s3.amazonaws.com/grafana-$VERSION.tar.gz"

rm -f current 2> /dev/null
mkdir -p current


curl -o grafana.tar.gz $DL_URL
tar -xvzf grafana.tar.gz 
mv grafana-*/* current

docker build --no-cache -t="jpthiery/grafana" .
