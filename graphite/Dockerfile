FROM ubuntu:14.04
MAINTAINER Jean-Pascal THIERY <jean-pascal@thiery.in>

RUN apt-get update && apt-get install -y graphite-web graphite-carbon apache2 libapache2-mod-wsgi supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN sed -i 's/CARBON_CACHE_ENABLED=false/CARBON_CACHE_ENABLED=true/' /etc/default/graphite-carbon
RUN sed -i "s/#SECRET_KEY = 'UNSAFE_DEFAULT'/SECRET_KEY = 'Coucou'/" /etc/graphite/local_settings.py
RUN sudo graphite-manage syncdb --noinput 
RUN  echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@voyages-sncf.com', 'admin')" | sudo graphite-manage shell

ADD storage-schemas.conf /etc/carbon/storage-schemas.conf 
ADD storage-aggregation.conf /etc/carbon/storage-aggregation.conf

RUN sudo cp /usr/share/graphite-web/apache2-graphite.conf /etc/apache2/sites-available/graphite.conf
RUN sudo a2dissite 000-default && sudo a2ensite graphite
RUN sed -i 's#event = json.loads(request.raw_post_data)#event = json.loads(request.body)#g' /usr/lib/python2.7/dist-packages/graphite/events/views.py

RUN chmod -R 777 /var/lib/graphite

ENTRYPOINT /usr/bin/supervisord

VOLUME ["/etc/carbon", "/etc/graphite"]

EXPOSE 2003 2004 7002 80