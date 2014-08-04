FROM ubuntu:latest
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

RUN apt-get update
RUN apt-get install -y puppetmaster git-core vim vim-puppet

RUN ln -s /etc/puppet/hiera.yaml /etc/hiera.yaml

ADD puppet.conf /etc/puppet/puppet.conf

VOLUME ["/etc/puppet/files", "/etc/puppet/manifests", "/etc/puppet/modules", "/etc/puppet/templates", "/etc/puppet/hiera", "/etc/puppet/enc"]

EXPOSE 8140

ENTRYPOINT puppet master --no-daemonize