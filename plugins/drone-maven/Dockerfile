# docker build --tag shuxs/drone-maven-docker-build:latest . && docker push shuxs/drone-maven-docker-build:latest
FROM shuxs/alpine:latest

RUN apk add --no-cache openjdk8 maven; \
    rm -rf /var/lib/apk /etc/apk/cache; \
    java -version; \
    mvn -v;

COPY ./entry_point.sh /

RUN chmod +x /entry_point.sh

CMD [ "/entry_point.sh" ]
