FROM openjdk:8-jre-alpine
ARG JAR
COPY ${JAR} /app.jar
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar=/app.jar" ]