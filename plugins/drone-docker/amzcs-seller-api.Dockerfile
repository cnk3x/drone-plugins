FROM shuxs/jre:latest
WORKDIR /app

COPY ./amzcs-seller-api-1.0.0.jar /app/amzcs-seller-api-1.0.0.jar

CMD ["java","-jar","/app/amzcs-seller-api-1.0.0.jar","-path=/app/app.config"]
