# docker build --tag shuxs/drone-maven:latest . && docker push shuxs/drone-maven:latest
FROM shuxs/docker-cli:latest

ENV LANG C.UTF-8

# RUN echo "http://mirrors.cloud.aliyuncs.com/alpine/v3.9/main" > /etc/apk/repositories; \
#     echo "http://mirrors.cloud.aliyuncs.com/alpine/v3.9/community" >> /etc/apk/repositories; 

RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories; \
    echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories; \
    apk add --no-cache openjdk8 maven;

COPY ./javaapp.Dockerfile ./entry_point.sh /

CMD [ "/entry_point.sh" ]
