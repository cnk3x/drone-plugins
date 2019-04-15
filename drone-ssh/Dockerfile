FROM alpine:3.9

RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories; \
    echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories; \
    apk add --no-cache --allow-untrusted ca-certificates openssh-client

COPY /entry_point.sh /

ENTRYPOINT [ "/entry_point.sh" ]