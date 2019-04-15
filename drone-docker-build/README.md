# Drone Maven 编译插件

https://github.com/shuxs/drone-env/tree/master/builder/drone-maven

## Build

```shell
docker build --tag shuxs/drone-maven:latest . && docker push shuxs/drone-maven:latest
```

## Demo

**.drone.yml**

```yaml
kind: pipeline
name: default

steps:
  - name: publish
    image: shuxs/drone-maven
    settings:
      username:
        from_secret: username
      password:
        from_secret: password
      registry:
        from_secret: registry
      namespace:
        from_secret: namespace
    volumes:
      - name: m2repository
        path: /root/.m2/repository
      - name: sock
        path: /var/run/docker.sock
      - name: docker
        path: /usr/bin/docker

volumes:
  - name: sock
    host:
      path: /var/run/docker.sock
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
