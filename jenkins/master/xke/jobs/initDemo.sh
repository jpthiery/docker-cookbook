#!/bin/bash
# Script to create a new CI docker project
#

PROJECT_NAME=$1
PROJECT_GIT_URL=$2
PROJECT_MVN_GRPID=$3
PROJECT_MVN_ARTID=$4
PROJECT_DCK_USER=$5
PROJECT_DCK_IMAGENAME=$6


if [ -z $4 ]; then
  usage
  exit 1
fi

usage() {
  SCRIPT=`basename $0`
  echo "Usage: $SCRIPT PROJECT_NAME PROJECT_GIT_URL PROJECT_MVN_GRPID PROJECT_MVN_ARTEFACTID"
}

if [ -z "$7" ]; then
  URL="http://192.168.59.101:8082"
else
  URL=$7
fi
JENKINS_CMD="java -jar jenkins-cli.jar -s $URL"

if [[ -x jenkins-cli.jar ]] 
then
	echo "Already get jenkins-cli"
else
	echo "Try to download jenkins-cli.jar"
	curl -o jenkins-cli.jar $URL/jnlpJars/jenkins-cli.jar
	chmod +x jenkins-cli.jar
fi

echo "Creating setup for $PROJECT_NAME"
echo "Parsing templates Jobs"
rm -rf $PROJECT_NAME
mkdir $PROJECT_NAME
cp templates/*.xml $PROJECT_NAME
chmod +wx $PROJECT_NAME/*.xml
sed -i "s#@@PROJECT_NAME@@#$PROJECT_NAME#g" ./$PROJECT_NAME/{checkout,int,{basic,performance}-gatling,view}.xml
sed -i "s#@@PROJECT_GITURL@@#$PROJECT_GIT_URL#g" ./$PROJECT_NAME/{checkout,int,{basic,performance}-gatling}.xml
sed -i "s#@@PROJECT_MVN_GRPID@@#$PROJECT_MVN_GRPID#g" ./$PROJECT_NAME/{checkout,int,{basic,performance}-gatling}.xml
sed -i "s#@@PROJECT_MVN_ARTID@@#$PROJECT_MVN_ARTID#g" ./$PROJECT_NAME/{checkout,int,{basic,performance}-gatling}.xml
sed -i "s#@@PROJECT_DCK_USER@@#$PROJECT_DCK_USER#g" ./$PROJECT_NAME/{checkout,int,{basic,performance}-gatling}.xml
sed -i "s#@@PROJECT_DCK_IMAGENAME@@#$PROJECT_DCK_IMAGENAME#g" ./$PROJECT_NAME/{checkout,int,{basic,performance}-gatling}.xml

echo "Creating Jobs"
$JENKINS_CMD create-job checkout-build-maven-$PROJECT_NAME < $PROJECT_NAME/checkout.xml
$JENKINS_CMD create-job int-docker-$PROJECT_NAME < $PROJECT_NAME/int.xml
$JENKINS_CMD create-job basic-gatling-$PROJECT_NAME < $PROJECT_NAME/basic-gatling.xml
$JENKINS_CMD create-job performance-gatling-$PROJECT_NAME < $PROJECT_NAME/performance-gatling.xml
echo "Creating view"
$JENKINS_CMD create-view ${PROJECT_NAME}-pipeline < $PROJECT_NAME/view.xml

# https://github.com/jpthiery/sample-web.git
