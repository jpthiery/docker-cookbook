FROM jenkins/master
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

COPY init.groovy /var/lib/jenkins/.jenkins/init.groovy
RUN su - jenkins -c "java -jar /usr/share/jenkins/jenkins.war"
RUN rm /var/lib/jenkins/.jenkins/init.groovy 