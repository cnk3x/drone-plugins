FROM openjdk:8-jre-alpine
ARG dist
COPY ${dist} /app.jar
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar" ]