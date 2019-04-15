# Drone Maven 编译插件

## Build

```shell
docker build --tag shuxs/drone-maven-docker-build:latest . && docker push shuxs/drone-maven-docker-build:latest
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
  -v /var/run/docker.sock:/var/run/docker.sock \
  shuxs/drone-maven-docker-build:latest
```

## Demo

**.drone.yml**

```yaml
kind: pipeline
name: default

steps:
  - name: build
    image: shuxs/drone-maven-docker-build
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
      - name: docker
        path: /var/run/docker.sock

volumes:
  - name: docker
    host:
      path: /var/run/docker.sock
  - name: m2repository
    host:
      path: /data/docker/drone/.m2/repository

trigger:
  event:
    - tag
    - tags
```
