# docker build -t shuxs/curl:latest -f curl.Dockerfile . && docker push shuxs/curl:latest
FROM shuxs/alpine

RUN apk add --no-cache --allow-untrusted jq curl && rm -rf /var/lib/apk /etc/apk/cache;