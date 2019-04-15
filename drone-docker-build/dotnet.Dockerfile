FROM  mcr.microsoft.com/dotnet/core/aspnet:2.2.4-alpine3.9
WORKDIR /app
ARG dist
ARG dll
COPY ${dist} /app
ENTRYPOINT [ "dotnet", "/app/${dll}" ]
