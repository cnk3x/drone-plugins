# docker build -t shuxs/docker-cli:latest . && docker push shuxs/docker-cli:latest
FROM alpine:3.9

RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories; \
    echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories; \
    apk add --no-cache --allow-untrusted ca-certificates curl && \
    export latest=`curl -s https://download.docker.com/linux/static/stable/x86_64/ | tail -n 2 |  head -n 1 | awk -F '"' '{print $2}'` && \
    echo ${latest} && \
    wget -O docker.tgz https://download.docker.com/linux/static/stable/x86_64/${latest} && \
    mkdir -p /docker && \
    tar --extract --file docker.tgz --strip-components 1 --directory /docker && \
    cp /docker/docker /usr/local/bin/ && \
    apk del --no-cache curl; \
    rm -rf docker.tgz /docker /var/lib/apk /etc/apk/cache; \
    docker --version;

CMD ["docker"]