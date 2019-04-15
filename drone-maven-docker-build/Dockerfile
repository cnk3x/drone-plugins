# docker build --tag shuxs/drone-maven-docker-build:latest . && docker push shuxs/drone-maven-docker-build:latest
FROM shuxs/docker-cli:latest

RUN apk add --no-cache openjdk8 maven;

COPY ./javaapp.Dockerfile ./drone-maven-docker-build.sh /

CMD [ "/drone-maven-docker-build.sh" ]
