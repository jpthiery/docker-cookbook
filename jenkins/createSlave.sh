#!/bin/bash
#
# Script to add new node in master jenkins via jenkins-cli
#

URL=$1
NODE_NAME=$2

if [[ -x jenkins-cli.jar ]] 
then
	echo "Already get cli"
else
	curl -o jenkins-cli.jar $URL/jnlpJars/jenkins-cli.jar
	chmod +x jenkins-cli.jar
fi
	
java -jar jenkins-cli.jar -s $URL create-node $NODE_NAME << EOF
<slave>
      <name>$NODE_NAME</name>
      <description>Jenkins slave at your service</description>
      <remoteFS>/</remoteFS>
      <numExecutors>1</numExecutors>
      <mode>NORMAL</mode>
      <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
      <launcher class="hudson.slaves.JNLPLauncher"/>
      <label>slave</label>
      <nodeProperties/>
      <userId>anonymous</userId>
</slave>
EOF
