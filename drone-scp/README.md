# Drone SSP 发布插件

## Build

```shell
docker build --tag shuxs/drone-scp:latest . && docker push shuxs/drone-scp:latest
```

## Demo

**.drone.yml**

```yaml
steps:
  - name: publish
    image: shuxs/drone-scp:latest
    settings:
      host: p01.shu.run
      dir: seller-ui/my
    volumes:
      - name: m2repository
        path: /root/.m2/repository
      - name: sshkey
        path: /root/.ssh/id_rsa

volumes:
  - name: sshkey
    host:
      path: /root/.ssh/id_rsa
```
