# drone maven 编译 和 docker build 插件

## Build

```shell
docker build --tag shuxs/drone-maven:latest . && docker push shuxs/drone-maven:latest
```

## Test

```
docker run --rm \
  -e PLUGIN_USERNAME=${username} \
  -e PLUGIN_PASSWORD=${password} \
  -e PLUGIN_REGISTRY=${registry} \
  -e PLUGIN_NAMESPACE=${namespace} \
  -v $(pwd):/drone/src \
  -w /drone/src \
  -v /data/docker/drone/.m2/repository:/root/.m2/repository \
  -v /var/run/docker.sock:/var/run/docker.sock \
  shuxs/drone-maven:latest
```

## Demo

**.drone.yml**

```yaml
kind: pipeline
name: default

steps:
  - name: build
    image: shuxs/drone-maven
    volumes:
      - name: m2repository
        path: /root/.m2/repository

volumes:
  - name: m2repository
    host:
      path: /data/docker/drone/.m2/repository

trigger:
  event:
    - tag
    - tags
```
