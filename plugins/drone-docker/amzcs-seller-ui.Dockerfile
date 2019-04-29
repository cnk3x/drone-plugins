FROM shuxs/caddy-vue:latest
WORKDIR /app
ENV \
    API_ADDR=http://amzcs-seller-api \
    WWW=/app/www
COPY dist /app/www


