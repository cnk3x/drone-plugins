FROM scratch
VOLUME ["/app.config"]
CMD [ "/app", "-c", "app.config" ]
