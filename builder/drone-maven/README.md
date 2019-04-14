# Drone Maven 编译发布插件

https://github.com/shuxs/drone-env/tree/master/builder/drone-maven

## Build

```shell
docker build --tag shuxs/drone-maven:3  \
  --tag shuxs/drone-maven:latest . && \
docker push shuxs/drone-maven:3 && \
docker push shuxs/drone-maven:latest
```

## Test

```
export username=******
export password=********
export registry=registry.cn-shenzhen.aliyuncs.com
export namespace=amzcs

docker run --rm \
  -e PLUGIN_USERNAME=${username} \
  -e PLUGIN_PASSWORD=${password} \
  -e PLUGIN_REGISTRY=${registry} \
  -e PLUGIN_NAMESPACE=${namespace} \
  -v $(pwd):/drone/src \
  -w /drone/src \
  -v /data/docker/drone/.m2/repository:/root/.m2/repository \
  -v /usr/bin/docker:/usr/bin/docker \
  -v /var/run/docker.sock:/var/run/docker.sock \
  shuxs/drone-maven:3
```

## Demo

**.drone.yml**

```yaml
kind: pipeline
name: default

steps:
  - name: publish
    image: shuxs/drone-maven:3
    settings:
      username: # 镜像服务器Push用户名
        from_secret: username
      password: # 镜像服务器Push密码
        from_secret: password
      registry: # 目标镜像服务器
        from_secret: registry
      namespace: # 仓库存储所在组织
        from_secret: namespace
    volumes:
      # 缓存maven下载的库
      - name: m2repository
        path: /root/.m2/repository
      # 连接主机的docker环境
      - name: sock
        path: /var/run/docker.sock
      - name: lib
        path: /var/lib/docker
      - name: docker
        path: /usr/bin/docker

volumes:
  - name: sock
    host:
      path: /var/run/docker.sock
  - name: lib
    host:
      path: /var/lib/docker
  - name: docker
    host:
      path: /usr/bin/docker
  - name: m2repository
    host:
      path: /data/docker/drone/.m2/repository

trigger:
  event:
    - tag
    - tags
```
