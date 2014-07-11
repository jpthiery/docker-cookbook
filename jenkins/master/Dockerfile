FROM jenkins/initial
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN apt-get update
RUN apt-get -y install openssh-server mvn git

RUN useradd -m -s /bin/bash jenkins && echo jenkins:jenkins | chpasswd && mkdir -p /var/run/sshd
CMD /usr/sbin/sshd -D

EXPOSE 8080
EXPOSE 22
EXPOSE 49275