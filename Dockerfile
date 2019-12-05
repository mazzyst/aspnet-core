 # Sample contents of Dockerfile
 # Stage 1
 FROM mcr.microsoft.com/dotnet/core/sdk AS builder
 WORKDIR /source

 # caches restore result by copying csproj file separately
 COPY *.csproj .
 RUN dotnet restore

 # copies the rest of your code
 COPY . .
 RUN dotnet publish --output /output --configuration Release

 # Stage 2
 FROM mcr.microsoft.com/dotnet/core/aspnet
 WORKDIR /app
 COPY --from=builder /output /app
 ENTRYPOINT ["dotnet", "AspNetCoreOnDocker.dll"]
