# docker build -t shuxs/jre:ossfs -f jre-ossfs.Dockerfile . && docker push shuxs/jre:ossfs
FROM openjdk:8-jre-alpine

RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories; \
    echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories; \ 
    apk add --no-cache fuse curl libxml2 openssl libstdc++ libgcc tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apk del --no-cache tzdata; \
    date;\
    rm -rf /var/lib/apk /etc/apk/cache; 

COPY ossfs-346a355 /usr/bin/ossfs
COPY ossfs-fs /usr/bin/fs
RUN chmod +x /usr/bin/ossfs && chmod +x /usr/bin/fs
ENV LANG C.UTF-8

ENTRYPOINT [ "fs" ]

CMD [ "java", "-version" ]