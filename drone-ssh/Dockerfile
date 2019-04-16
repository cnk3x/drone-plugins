# docker build --tag shuxs/drone-ssh:latest . && docker push shuxs/drone-ssh:latest
FROM shuxs/alpine:latest

RUN apk add --no-cache --allow-untrusted openssh-client; \
    rm -rf ${latest} /docker /var/lib/apk /etc/apk/cache; 

COPY /entry_point.sh /

ENTRYPOINT [ "/entry_point.sh" ]