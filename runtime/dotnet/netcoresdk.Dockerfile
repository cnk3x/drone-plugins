# docker build -t shuxs/netcoresdk:latest -t shuxs/netcoresdk:2.2.203 -f netcoresdk.Dockerfile . && docker push shuxs/netcoresdk
FROM mcr.microsoft.com/dotnet/core/sdk:2.2.203-alpine3.9

RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories; \
    echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories; \
    apk add --no-cache --allow-untrusted ca-certificates tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apk del --no-cache tzdata; \
    date;\
    rm -rf /var/lib/apk /etc/apk/cache; 

ENV LANG C.UTF-8

CMD ["dotnet", "--info"]
