FROM jenkins/runner:test
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN apt-get update
RUN apt-get -y install curl maven git

COPY createSlave.sh createSlave.sh

ENTRYPOINT exec /./createSlave.sh