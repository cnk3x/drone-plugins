# docker build shuxs/yarn:latest . && docker push shuxs/yarn:latest
FROM shuxs/alpine:latest

RUN apk add --no-cache yarn &&  \
    rm -rf /var/lib/apk /etc/apk/cache

CMD [ "yarn","-v" ]