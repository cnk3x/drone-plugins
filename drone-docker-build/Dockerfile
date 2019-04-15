# docker build -t shuxs/drone-docker-build:latest . && docker push shuxs/drone-docker-build:latest
FROM shuxs/docker-cli:latest

COPY dotnet.Dockerfile java.Dockerfile native.Dockerfile ./drone-docker-build.sh /

CMD [ "/drone-docker-build.sh" ]
