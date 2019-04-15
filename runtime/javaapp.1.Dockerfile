FROM openjdk:8-jre-alpine
ARG JAR
ADD ${JAR} /app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar","-path=/app.config"]