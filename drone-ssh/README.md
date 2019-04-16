# Drone SSH 发布插件

## Build

```shell
docker build --tag shuxs/drone-ssh:latest . && docker push shuxs/drone-ssh:latest
```

## Demo

**.drone.yml**

```yaml
steps:
  - name: publish
    image: shuxs/drone-ssh:latest
    settings:
      name: promotion-api #需要改
      publish: 58080:8080 #需要改
      username:
        from_secret: username
      password:
        from_secret: password
      registry:
        from_secret: registry
      namespace:
        from_secret: namespace
      host:
        from_secret: host
      port:
        from_secret: port
      user:
        from_secret: user
      key:
        from_secret: key
      network:
        from_secret: network
      run_at_hostname:
        from_secret: run_at_hostname
```
