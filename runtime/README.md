# 语言运行时基础容器

https://github.com/shuxs/drone-env/tree/master/runtime

## Java

> `shuxs/javaapp`

**Build**

```shell
docker build -f javaapp.Dockerfile --tag shuxs/javaapp:latest . && \
docker push shuxs/javaapp:latest
```

## Go

> `shuxs/go:latest` \
> go 不需要任何运行时，是个空环境

**Build**

```shell
docker build -f goapp.Dockerfile --tag shuxs/goapp:latest . && \
docker push shuxs/goapp:latest
```
