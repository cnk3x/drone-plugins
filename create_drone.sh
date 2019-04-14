export host=*****
export rpc_secret=********
export admin_username=******
export mysql_dsn=****************
export gitea_url=****************
export port=54321
export network=drone_network
export agent_run_name=agent01

docker run --name drone \
    --detach=true \
    --restart=always \
    --hostname=drone \
    --network=${network} \
    --publish=${port}:80 \
    --env=DRONE_GITEA_SERVER=${gitea_url} \
    --env=DRONE_GITEA_SKIP_VERIFY=false \
    --env=DRONE_GIT_ALWAYS_AUTH=true \
    --env=DRONE_SERVER_PROTO=https \
    --env=DRONE_SERVER_HOST=${host} \
    --env=DRONE_TLS_AUTOCERT=false \
    --env=DRONE_DATABASE_DRIVER=mysql \
    --env=${mysql_dsn} \
    --env=DRONE_USER_CREATE=username:${admin_username},admin:true \
    --env=DRONE_AGENTS_ENABLED=true \
    --env=DRONE_RPC_SECRET=${rpc_secret} \
    --env=DRONE_LOGS_DEBUG=true \
    --env=DRONE_LOGS_TEXT=true \
    --env=DRONE_LOGS_PRETTY=true \
    --env=DRONE_LOGS_COLOR=true \
    drone/drone:1

docker run --name=drone-agent \
    --detach=true \
    --restart=always \
    --volume=/var/run/docker.sock:/var/run/docker.sock \
    --env=DRONE_RPC_SERVER=https://${host} \
    --env=DRONE_RPC_SECRET=${rpc_secret} \
    --env=DRONE_RUNNER_NAME=${agent_run_name} \
    --env=DRONE_RUNNER_CAPACITY=2 \
    --env=DRONE_LOGS_DEBUG=true \
    --env=DRONE_LOGS_TEXT=true \
    --env=DRONE_LOGS_PRETTY=true \
    --env=DRONE_LOGS_COLOR=true \
    drone/agent:1
