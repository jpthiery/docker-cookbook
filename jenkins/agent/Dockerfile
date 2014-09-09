FROM jpthiery/java8
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN apt-get update
RUN apt-get -y install curl maven git-core openssh-server

RUN useradd -m -s /bin/bash jenkins
RUN echo jenkins:jenkins | chpasswd
RUN mkdir -p /var/run/sshd

#ENTRYPOINT /usr/sbin/sshd -D

EXPOSE 22

#ENTRYPOINT exec /./createSlave.sh