#!/bin/bash


echo "Lanch jenkins master node"
docker run -d -p 8080:8080 --name="jenkinsMaster" jenkins/master

sleep 30s

docker run -d -e NODE_NAME=slaveA --link jenkinsMaster:master --volumes-from jenkinsMaster jenkins/agent
docker run -d -e NODE_NAME=slaveB --link jenkinsMaster:master --volumes-from jenkinsMaster jenkins/agent
docker run -d -e NODE_NAME=slaveC --link jenkinsMaster:master --volumes-from jenkinsMaster jenkins/agent
docker run -d -e NODE_NAME=slaveD --link jenkinsMaster:master --volumes-from jenkinsMaster jenkins/agent