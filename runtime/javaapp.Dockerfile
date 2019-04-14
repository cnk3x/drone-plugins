FROM shuxs/java:8
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Xms64m -Xmx256m"
VOLUME [ "/app.config" ]
ENTRYPOINT [ "sh", "-c", "java ${JAVA_OPTS} -jar /app.jar -path=/app.config" ]