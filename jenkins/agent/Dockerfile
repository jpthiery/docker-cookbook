FROM jpthiery/java8
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN apt-get update
RUN apt-get -y install curl docker.io unzip git-core openssh-server

RUN echo root:root | chpasswd
ADD id_rsa.pub /root/.ssh/id_rsa.pub
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN chmod -R 600 /root/.ssh 
RUN mkdir -p /var/run/sshd

CMD /usr/sbin/sshd -D

EXPOSE 22
#docker inspect mad_hoover --format='{{(index (index .NetworkSettings.Ports "4567/tcp") 0).HostPort}}' 
#ENTRYPOINT exec /./createSlave.sh