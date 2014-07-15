#!/bin/bash


echo "Lanch jenkins master node"
docker run -d -p 8080:8080 --name="jenkinsMasterWorkflow" jenkins/masterworkflowplugin

sleep 15s

docker run -d -e NODE_NAME=slaveA --link jenkinsMasterWorkflow:master --volumes-from jenkinsMasterWorkflow jenkins/agent
docker run -d -e NODE_NAME=slaveB --link jenkinsMasterWorkflow:master --volumes-from jenkinsMasterWorkflow jenkins/agent