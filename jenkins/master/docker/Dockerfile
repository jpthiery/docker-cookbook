FROM jpthiery/jenkinsmaster
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN apt-get update
RUN apt-get install -y docker.io

COPY init.groovy /var/lib/jenkins/.jenkins/init.groovy
RUN su - jenkins -c "java -jar /usr/share/jenkins/jenkins.war"
RUN rm /var/lib/jenkins/.jenkins/init.groovy 
