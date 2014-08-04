#Build
```bash
docker build -t="jpthiery/puppetmaster" puppet/master
docker build -t="jpthiery/puppetagent" puppet/agent
```

#Run
```bash
docker run -d --name="puppetmaster" -h puppet -p 8140:8140 \
	-v /workspace/puppet/files:/etc/puppet/files  \
	-v /workspace/puppet/manifest:/etc/puppet/manifests \
	-v /workspace/puppet/modules:/etc/puppet/modules \
	-v /workspace/puppet/templates:/etc/puppet/templates \
	-v /workspace/puppet/hiera:/etc/puppet/hiera \
	-v /workspace/puppet/enc:/etc/puppet/enc \
	jpthiery/puppetmaster

docker run -it --rm --link puppetmaster:puppet -h $1 jpthiery/puppetagent /bin/bash
```