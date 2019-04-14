# Drone Maven 编译发布插件

https://github.com/shuxs/drone-env/tree/master/builder/drone-maven

## Build

```shell
docker build --tag shuxs/drone-maven:3  \
  --tag shuxs/drone-maven:latest .
docker push shuxs/drone-maven:3
docker push shuxs/drone-maven:latest
```

## Demo

**.drone.yml**

```yaml
kind: pipeline
name: default

steps:
  - name: build_publish
    image: shuxs/drone-maven:3
    settings:
      username: # 镜像服务器Push用户名
        from_secret: username
      password: # 镜像服务器Push密码
        from_secret: password
      registry: # 目标镜像服务器
        from_secret: registry
      group: # 仓库存储所在组织
        from_secret: group
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
