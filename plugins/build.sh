docker build -t shuxs/docker-cli:latest ./docker-cli && docker push shuxs/docker-cli:latest
docker build -t shuxs/drone-docker-build:latest ./drone-docker-build && docker push shuxs/drone-docker-build:latest
docker build -t shuxs/drone-maven-docker-build:latest ./drone-maven-docker-build && docker push shuxs/drone-maven-docker-build:latest
docker build -t shuxs/drone-scp-dist:latest ./drone-scp-dist && docker push shuxs/drone-scp-dist:latest

docker pull shuxs/docker-cli:latest
docker pull shuxs/drone-docker-build:latest
docker pull shuxs/drone-maven-docker-build:latest
docker pull shuxs/drone-scp-dist:latest
