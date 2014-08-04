#!/bin/bash

removeContainer() {
	IMAGE_NAME=$1
	if [ "$(docker ps -a --no-trunc | grep $IMAGE_NAME | wc -l)" -ne "0" ]; then
		DOCKER_ID=$(docker ps -a --no-trunc | grep $IMAGE_NAME | awk '{print $1}')
		docker stop $DOCKER_ID	
		docker rm $DOCKER_ID
	fi
}

removeContainer puppetagent
removeContainer puppetmaster
if [ "$1" != "REM" ]; then
	docker run -d --name="puppetmaster" -h puppet -p 8140:8140 \
		-v /workspace/puppet/files:/etc/puppet/files  \
		-v /workspace/puppet/manifest:/etc/puppet/manifests \
		-v /workspace/puppet/modules:/etc/puppet/modules \
		-v /workspace/puppet/templates:/etc/puppet/templates \
		-v /workspace/puppet/hiera:/etc/puppet/hiera \
		-v /workspace/puppet/enc:/etc/puppet/enc \
		jpthiery/puppetmaster

	docker run -it --rm --link puppetmaster:puppet -h $1 jpthiery/puppetagent /bin/bash
	
else
	if [ "$2" == "master" ]; then
		docker run -it --rm --name="puppetmaster" -h puppet -p 8140:8140 \
			-v /workspace/puppet/files:/etc/puppet/files  \
			-v /workspace/puppet/manifest:/etc/puppet/manifests \
			-v /workspace/puppet/modules:/etc/puppet/modules \
			-v /workspace/puppet/templates:/etc/puppet/templates \
			-v /workspace/puppet/hiera:/etc/puppet/hiera \
			-v /workspace/puppet/enc:/etc/puppet/enc \
			--entrypoint /bin/bash jpthiery/puppetmaster -i
	fi
fi