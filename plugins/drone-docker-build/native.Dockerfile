FROM shuxs/ossfs:latest
WORKDIR /app
ARG dist
COPY ${dist} /app/app
ENTRYPOINT [ "/app/app" ]
