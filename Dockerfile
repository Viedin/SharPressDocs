# Native AOT build: a single native binary on the chiseled runtime-deps image (no .NET runtime, no shell, non-root).

FROM mcr.microsoft.com/dotnet/sdk:11.0-preview-resolute-aot AS build
WORKDIR /src
COPY SharPressDocs.csproj .
RUN dotnet restore -r linux-x64 -p:PublishAot=true
COPY . .
# No debug symbols (.dbg, ~55MB), optimize for size over speed.
RUN dotnet publish -c Release -r linux-x64 --no-restore -o /app \
    -p:PublishAot=true -p:DebugType=none -p:DebugSymbols=false -p:OptimizationPreference=Size \
 && rm -f /app/*.dbg

FROM mcr.microsoft.com/dotnet/runtime-deps:11.0-preview-resolute-chiseled
WORKDIR /app
COPY --from=build /app .
EXPOSE 8080
ENTRYPOINT ["./SharPressDocs"]
