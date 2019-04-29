# docker build -t shuxs/docker-cli:latest . && docker push shuxs/docker-cli:latest
FROM shuxs/alpine:latest

RUN apk add --no-cache --allow-untrusted curl; \
    export latest=`curl -s https://download.docker.com/linux/static/stable/x86_64/ | tail -n 2 |  head -n 1 | awk -F '"' '{print $2}'`; \
    echo "latest docker install packge: ${latest}"; \
    wget -O ${latest} "https://download.docker.com/linux/static/stable/x86_64/${latest}"; \
    tar -xzv --strip-components=1 --directory=/usr/local/bin --file=${latest} docker/docker; \
    apk del --no-cache curl; \
    rm -rf ${latest} /docker /var/lib/apk /etc/apk/cache; \
    docker --version;

CMD ["docker", "info"]
