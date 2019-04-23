FROM shuxs/aspnet:ossfs
WORKDIR /app
ARG dist
ARG dll
COPY ${dist} /app
ENTRYPOINT [ "dotnet", "/app/${dll}" ]
