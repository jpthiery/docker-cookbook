FROM jenkins/initial
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN apt-get update
RUN apt-get -y install openssh-server maven git

ENV JENKINS_HOME /var/lib/jenkins

#RUN useradd -m -s /bin/bash jenkins && echo jenkins:jenkins | chpasswd && mkdir -p /var/run/sshd
CMD /usr/sbin/sshd -D

COPY config.xml /var/lib/jenkins/.jenkins/config.xml
COPY id_rsa.pub /tmp/id_rsa.pub

RUN mkdir -p /var/lib/jenkins/.jenkins/.ssh/ && echo /tmp/id_ras.pub > /var/lib/jenkins/.jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /var/lib/jenkins


#ENTRYPOINT su - jenkins -c "java -jar /usr/share/jenkins/jenkins.war"

EXPOSE 8080
EXPOSE 22
EXPOSE 49275