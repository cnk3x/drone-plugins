# 语言运行时基础容器

https://github.com/shuxs/drone-env/tree/master/runtime

## Java

> `shuxs/javaapp:8`

**CommandLine**

> `JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Xms64m -Xmx256m"` \
> `java ${JAVA_OPTS} -jar /app.jar -path=/app.config`

**Build**

```shell
docker build -f javaapp.Dockerfile \
    --tag shuxs/javaapp:8 \
    --tag shuxs/javaapp:latest \
    . && \
docker push shuxs/javaapp:8 && \
docker push shuxs/javaapp:latest && \
```

## Go

> `shuxs/go:latest` \
> go 不需要任何运行时，是个空环境

**CommandLine**

> `/app -c app.config`

**Build**

```shell
docker build -f goapp.Dockerfile --tag shuxs/goapp:latest . && \
docker push shuxs/goapp:latest
```
