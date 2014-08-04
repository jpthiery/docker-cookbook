FROM debian:latest
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN apt-get update
RUN apt-get -y install puppet ruby-hiera-puppet git-core vim vim-puppet 

ADD puppet.conf /etc/puppet/puppet.conf