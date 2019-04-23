FROM shuxs/jre:ossfs
WORKDIR /app
ARG dist
COPY ${dist} /app/app.jar
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/.jar" ]