FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
COPY src /app
WORKDIR /app

RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app
COPY --from=build-env /app/Identity/out .
ENV ASPNETCORE_URLS http://*:5000
ENTRYPOINT ["dotnet", "Identity.API.dll"]