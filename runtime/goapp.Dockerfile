FROM scratch
ARG APP
COPY ${APP} /app
ENTRYPOINT [ "/app" ]
