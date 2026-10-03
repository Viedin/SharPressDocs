# Getting started

## Install

```bash
dotnet new web -n MyDocs   # or use an existing app
cd MyDocs
dotnet add package SharPress --prerelease
```

## Register

```csharp
using SharPress;

var builder = WebApplication.CreateBuilder(args);
builder.AddSharPress();

var app = builder.Build();
app.UseSharPress();
app.Run();
```

| Call | Does |
| ---- | ---- |
| `AddSharPress()` | Registers services. Takes an optional [options](/docs/options) callback |
| `UseSharPress()` | Creates the site folder, adds middleware, maps endpoints |

App already has pages at `/`? Set [`BaseUrl`](/docs/urls#existing-app).

## Run

```bash
dotnet run
```

## Site folder

Created on first run:

```text
SharpLib/
├── Index.md          home page
├── sharpress.json    title, sidebar, home layout
├── docs/             pages, served under /docs
└── public/           logo, favicon, images, custom.css; served from /
```

Edit and refresh. No build, no restart. Existing files are never overwritten.

## Endpoints

| URL | Source |
| --- | ------ |
| `/` | `Index.md` + `home` in `sharpress.json` |
| `/docs/{slug}` | `docs/{slug}.md` |
| `/sitemap.xml` | Generated, see [URLs](/docs/urls#sitemap) |
| `/{file}` | `public/{file}` |
