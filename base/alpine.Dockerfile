# docker build -t shuxs/alpine:latest -f alpine.Dockerfile . && docker push shuxs/alpine:latest
FROM alpine:3.9

# RUN echo "http://mirrors.cloud.aliyuncs.com/alpine/v3.9/main" > /etc/apk/repositories; \
#     echo "http://mirrors.cloud.aliyuncs.com/alpine/v3.9/community" >> /etc/apk/repositories; 

RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories; \
    echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories; \
    apk add --no-cache --allow-untrusted ca-certificates tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apk del --no-cache tzdata; \
    date;\
    rm -rf /var/lib/apk /etc/apk/cache; 

ENV LANG C.UTF-8
