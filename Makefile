DOCKER_IP=$(shell boot2docker ip | grep -oE '[^ ]+$$')
EXPOSE_PORT=$(shell docker port spring-music | grep -oE ':[^ ]+$$')

docker-image:
	docker build  -t bonzofenix/spring-music .

docker-ssh: docker-run-daemon
	docker exec -it spring-music bash ; docker rm -f spring-music

docker-push:
	docker push bonzofenix/spring-music

docker-rm:
	docker rm -f spring-music

docker-run-daemon:
	docker run --name=spring-music -d -P bonzofenix/spring-music

docker-run:
	docker run --name=spring-music -P bonzofenix/spring-music

docker-route:
	$(DOCKER_IP)$(EXPOSE_PORT)/spring-music 

diego-push:
	 cf docker-push spring-music bonzofenix/spring-music
	 cf scale spring-music -m 1G
