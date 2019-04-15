FROM alpine:3.9

RUN apk update && apk add openssh-client

COPY /entry_point.sh /
RUN chmod +x /entry_point.sh

ENTRYPOINT [ "/entry_point.sh" ]