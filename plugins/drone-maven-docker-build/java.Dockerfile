FROM shuxs/jre:ossfs
WORKDIR /app
ARG dist
COPY ${dist} /app/app.jar
CMD [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar","-path=/app/app.config" ]