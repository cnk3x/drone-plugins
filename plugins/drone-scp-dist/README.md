# Drone SSP 发布插件

## Build

```shell
docker build --tag shuxs/drone-scp-dist:latest . && docker push shuxs/drone-scp-dist:latest
```

## Demo

**.drone.yml**

```yaml
kind: pipeline
name: default

steps:
  - name: build
    image: node:alpine
    commands:
      - yarn install
      - yarn build

  - name: publish
    image: shuxs/drone-scp-dist
    settings:
      name:
        from_secret: name
      host:
        from_secret: host
      identity:
        from_secret: identity

trigger:
  event:
    - tag
    - tags
```
