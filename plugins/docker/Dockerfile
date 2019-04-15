FROM golang:alpine

COPY ./java.Dockerfile ./entry_point.sh /
RUN chmod +x /entry_point.sh

CMD [ "/entry_point.sh" ]
