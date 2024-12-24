#Build Phase
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build-env
WORKDIR /app

COPY ./PlordleApi/*.csproj ./
RUN dotnet restore

COPY ./PlordleApi ./
RUN mkdir /app/transfermarkt-scraper
COPY ./transfermarkt-scraper/PlayerData.csv /app/transfermarkt-scraper
# Build and publish a release
RUN dotnet publish -c release -o out

#Deploy Phase
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build-env /app/out .
COPY --from=build-env /app/transfermarkt-scraper /transfermarkt-scraper

ENTRYPOINT ["dotnet", "PlordleApi.dll"]