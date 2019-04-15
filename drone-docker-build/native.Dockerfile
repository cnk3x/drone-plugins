FROM scratch
ARG dist
COPY ${dist} /app
ENTRYPOINT [ "/app" ]
