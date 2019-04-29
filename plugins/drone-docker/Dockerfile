# docker build -t shuxs/drone-docker:latest . && docker push shuxs/drone-docker:latest
FROM shuxs/docker-cli:latest

RUN apk add --no-cache jq

COPY entry_point.sh /
RUN chmod +x /entry_point.sh

CMD [ "/entry_point.sh" ]
