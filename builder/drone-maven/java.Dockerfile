FROM shuxs/javaapp:8

ARG JAR

COPY ${JAR} /app.jar