# Deployment

Deploy as any ASP.NET Core app. SharPress-specific concerns below.

Example: [this site's repo](https://github.com/Viedin/SharPressDocs) (native AOT Docker image, Docker Compose,
Cloudflare Tunnel).

## Publish SharpLib

`dotnet publish` copies only `.json` files from `SharpLib/` by default. Without `docs/`, the published app
creates and serves the starter pages. Include the folder:

```xml
<ItemGroup>
  <Content Remove="SharpLib\**" />
  <Content Include="SharpLib\**" CopyToPublishDirectory="PreserveNewest" />
</ItemGroup>
```

Or keep content outside the app with an absolute `RootFolder`. Files are read per request, so content can be
updated without redeploying.

## Starter files

`StaticFolder` is created at startup, so `RootFolder` must exist or be writable. To prevent starter pages in
production:

```csharp
builder.AddSharPress(options => options.CreateStarterFiles = !builder.Environment.IsProduction());
```

## Native AOT

Works, but builds with trim/AOT warnings. Some features may fail at runtime; test before relying on it.
