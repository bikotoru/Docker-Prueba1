FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["DockerTest1/DockerTest1.csproj", "DockerTest1/"]
RUN dotnet restore "DockerTest1/DockerTest1.csproj"
COPY . .
WORKDIR "/src/DockerTest1"
RUN dotnet build "DockerTest1.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "DockerTest1.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DockerTest1.dll"]