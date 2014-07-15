FROM runner/java8
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN apt-get update
RUN apt-get -y install curl maven git ntp

RUN echo "server 0.fr.pool.ntp.org iburst dynamic\nserver 1.fr.pool.ntp.org iburst dynamic\nserver 2.fr.pool.ntp.org iburst dynamic\nserver 3.fr.pool.ntp.org iburst dynamic" > /etc/ntp.conf && /etc/init.d/ntp restart

COPY createSlave.sh createSlave.sh

ENTRYPOINT exec /./createSlave.sh