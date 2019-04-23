# docker build -t shuxs/jre:ossfs -f jre-ossfs.Dockerfile . && docker push shuxs/jre:ossfs
FROM shuxs/ossfs:latest

RUN apk add --no-cache openjdk8  && rm -rf /var/lib/apk /etc/apk/cache; 
