#!/bin/bash
# Script to add new node in master jenkins via jenkins-cli
#

URL="http://${MASTER_PORT_8080_TCP_ADDR}:${MASTER_PORT_8080_TCP_PORT}"

mkdir -p /root/.ssh
cp /shared/sshkey/* /root/.ssh/

if [[ -x jenkins-cli.jar ]] 
then
	echo "Already get jenkins-cli"
else
	echo "Try to download jenkins-cli.jar"
	curl -o jenkins-cli.jar $URL/jnlpJars/jenkins-cli.jar
	chmod +x jenkins-cli.jar
fi

echo "Creating slave node $NODE_NAME"
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
      <userId>jenkins</userId>
</slave>
EOF

if [[ -x slave.jar ]]
then
	echo "Already get slave.jar"
else
	echo "Try to download slave.jar"
	curl -o slave.jar $URL/jnlpJars/slave.jar
	chmod +x slave.jar
fi

echo "Launching slave agent"
java -jar slave.jar -jnlpUrl $URL/computer/$NODE_NAME/slave-agent.jnlp
