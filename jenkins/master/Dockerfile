FROM jpthiery/java8
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list && wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -

RUN apt-get update
RUN apt-get -y install jenkins openssh-server git-core

CMD /usr/sbin/sshd -D

ENV JENKINS_HOME /var/lib/jenkins

COPY config.xml /var/lib/jenkins/.jenkins/config.xml
COPY user_config.xml /tmp/user_config.xml
COPY user_sshkey.sed /tmp/user_sshkey.sed

#RUN ssh-keygen -b 2048 -t rsa -f /var/lib/jenkins/sshkey -q -N "" 

# Add generate ssh keys
ADD id_rsa /var/lib/jenkins/id_rsa
ADD id_rsa.pub /var/lib/jenkins/id_rsa.pub
RUN chmod 600 /var/lib/jenkins/id_rsa* 

RUN mkdir -p /var/lib/jenkins/.jenkins/users/jenkins/ && sed -f /tmp/user_sshkey.sed /tmp/user_config.xml > /var/lib/jenkins/.jenkins/users/jenkins/config.xml

RUN mkdir -p /var/lib/jenkins/.ssh/ && cat /var/lib/jenkins/id_rsa.pub > /var/lib/jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /var/lib/jenkins

ENTRYPOINT exec su - jenkins -c "java -jar /usr/share/jenkins/jenkins.war"

EXPOSE 8080 22 49275