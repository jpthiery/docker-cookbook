FROM runner/java8
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list && wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -

RUN apt-get update
RUN apt-get -y install jenkins openssh-server

CMD /usr/sbin/sshd -D

ENV JENKINS_HOME /var/lib/jenkins

COPY config.xml /var/lib/jenkins/.jenkins/config.xml
COPY user_config.xml /tmp/user_config.xml
COPY user_sshkey.sed /tmp/user_sshkey.sed


RUN ssh-keygen -b 2048 -t rsa -f /var/lib/jenkins/sshkey -q -N "" 

RUN mkdir -p /shared/sshkey && cp /var/lib/jenkins/sshkey* /shared/sshkey/
VOLUME /shared
RUN mkdir -p /var/lib/jenkins/.jenkins/users/jenkins/ && sed -f /tmp/user_sshkey.sed /tmp/user_config.xml > /var/lib/jenkins/.jenkins/users/jenkins/config.xml

RUN mkdir -p /var/lib/jenkins/.jenkins/.ssh/ && cat /var/lib/jenkins/sshkey.pub > /var/lib/jenkins/.jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /var/lib/jenkins

ENTRYPOINT exec su - jenkins -c "java -jar /usr/share/jenkins/jenkins.war"

EXPOSE 8080 22 49275