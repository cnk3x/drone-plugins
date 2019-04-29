# drone docker 插件

## Build

```shell
docker build -t shuxs/drone-docker:latest . && docker push shuxs/drone-docker:latest
```

## Demo

**.drone.yml**

```yaml
kind: pipeline
name: default

steps:
  - name: docker-build
    image: shuxs/drone-docker
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
      - name: sock
        path: /var/run/docker.sock

volumes:
  - name: sock
    host:
      path: /var/run/docker.sock

trigger:
  event:
    - tag
```
