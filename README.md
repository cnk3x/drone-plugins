# drone 插件

docker-cli : docker in docker

drone-docker-build : build docker image

drone-maven-docker-build : maven build and docker image build

drone-ssh : run ssh

## build

```shell
docker build -t shuxs/alpine:latest -f alpine.Dockerfile . && docker push shuxs/alpine:latest
docker build -t shuxs/drone-docker-build:latest . && docker push shuxs/drone-docker-build:latest
docker build -t shuxs/drone-maven-docker-build:latest . && docker push shuxs/drone-maven-docker-build:latest
docker build -t shuxs/drone-ssh:latest . && docker push shuxs/drone-ssh:latest
```
