FROM openjdk:8-jre-alpine
ARG JAR
COPY ${JAR} /app.jar
ENTRYPOINT [ "/usr/bin/java", "-Djava.security.egd=file:/dev/./urandom", "-jar=/app.jar", "-path=/app.config" ]