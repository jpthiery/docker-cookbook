FROM ubuntu
MAINTAINER Jean-Pascal Thiery <jean-pascal@thiery.in>

#RUN apt-get update
#RUN apt-get install -y python-software-properties
RUN apt-get update
RUN apt-get install -y make ruby1.9.1-dev ruby nodejs
RUN gem install jekyll

RUN gem install jekyll

VOLUME ["source", "site"]

EXPOSE 4000
ENTRYPOINT /bin/bash -l -c "jekyll serve --source /source --destination /site -w"