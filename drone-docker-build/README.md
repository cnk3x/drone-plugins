# drone docker 插件

## Build

```shell
docker build -t shuxs/drone-docker-build:latest . && docker push shuxs/drone-docker-build:latest
```

## Demo

**.drone.yml**

```yaml
kind: pipeline
name: default

steps:
  - name: docker-build
    image: shuxs/drone-docker-build
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
