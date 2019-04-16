# docker build --tag shuxs/drone-scp:latest . && docker push shuxs/drone-scp:latest
FROM shuxs/alpine:latest

RUN apk add --no-cache --allow-untrusted openssh-client sshpass; rm -rf /var/lib/apk /etc/apk/cache; 

COPY drone-scp.sh /

ENV BASE_DIR=/data/amzcs/www

ENTRYPOINT [ "/drone-scp.sh" ]