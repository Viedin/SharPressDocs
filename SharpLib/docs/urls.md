# URLs

| Setting | Moves | Example |
| ------- | ----- | ------- |
| `BaseUrl` | Whole site | `/help/docs/install` |
| `DocsUrl` | Pages, inside the site | `/guide/install` |
| `UsePathBase` | Whole app | `/myapp/docs/install` |

## DocsUrl

```csharp
builder.AddSharPress(options => options.DocsUrl = "guide"); // docs/install.md -> /guide/install
```

- Multiple segments allowed: `"guide/v2"`.
- Links in `sharpress.json` and pages must use the new prefix: `/guide/install`.
- `""` or `"/"` serves pages at the site root (`/install`). The docs then catch every unmatched URL under
  `BaseUrl`, so set `BaseUrl` if the app has its own pages.

## BaseUrl

```csharp
builder.AddSharPress(options => options.BaseUrl = "help");
```

| Resource | URL |
| -------- | --- |
| Home | `/help` |
| `docs/install.md` | `/help/docs/install` |
| `public/logo.svg` | `/help/logo.svg` |
| Sitemap | `/help/sitemap.xml` |

- `/` links in settings and Markdown are relative to `BaseUrl`. No changes needed.
- Link outside the site with a full URL.
- SharPress's error page and HTTPS middleware only apply under `BaseUrl`.

## Existing app

If the app has its own endpoint at `/` (MVC, Razor Pages), set `BaseUrl`. Otherwise `/` throws
`AmbiguousMatchException`.

```csharp
builder.Services.AddControllersWithViews();
builder.AddSharPress(options => options.BaseUrl = "faq");

var app = builder.Build();
app.UseSharPress();
app.MapDefaultControllerRoute();
app.Run();
```

## Path base

All generated links and `/` links in Markdown get the path base. Call `UseRouting` directly after
`UsePathBase`, otherwise routes match before the base is stripped and every page 404s:

```csharp
app.UsePathBase("/myapp");
app.UseRouting();
app.UseSharPress();
```

## Reverse proxy

Absolute URLs (sitemap) use the request's scheme and host. Behind a proxy, forward them:

```csharp
using Microsoft.AspNetCore.HttpOverrides;

builder.Services.Configure<ForwardedHeadersOptions>(o =>
    o.ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto | ForwardedHeaders.XForwardedHost);

var app = builder.Build();
app.UseForwardedHeaders();
app.UseSharPress();
```

See [proxy configuration](https://learn.microsoft.com/aspnet/core/host-and-deploy/proxy-load-balancer).

## Sitemap

`/sitemap.xml` (moves with `BaseUrl`):

- Home page, if any.
- Every docs page sorted by path, including pages not in the sidebar.
- Generated per request.
- Requires sign-in when `RequireAuthorization` is on.
- `public/sitemap.xml` replaces it.

## Middleware added by UseSharPress

Scoped to requests under `BaseUrl`:

| Middleware | Environments |
| ---------- | ------------ |
| HTTPS redirection | All |
| Antiforgery | All |
| HSTS | Non-Development |
| SharPress error page | Non-Development |
