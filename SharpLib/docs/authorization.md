# Sign-in

Uses the app's existing authentication (cookies, Identity, OIDC, Entra ID, ...).

## Any authenticated user

```csharp
builder.Services.AddAuthentication().AddCookie();
builder.Services.AddAuthorization();
builder.AddSharPress(options => options.RequireAuthorization = true);
```

Applies the app's default policy. Startup throws if authentication or authorization isn't registered.

## Named policy

```csharp
builder.Services.AddAuthorization(o =>
    o.AddPolicy("DocsReaders", p => p.RequireRole("staff")));

builder.AddSharPress(options => options.AuthorizationPolicy = "DocsReaders");
```

Setting `AuthorizationPolicy` implies `RequireAuthorization`. An unknown policy name throws on request.

## Scope

| Protected | Public |
| --------- | ------ |
| Home page | SharPress CSS/JS, icons, highlight.js (`/_content/SharPress/*`) |
| Docs pages, including 404 | Error page |
| `public/` files | |
| `/sitemap.xml` | |

## Unauthorized requests

| Case | Response |
| ---- | -------- |
| Not signed in | Scheme challenge (e.g. redirect to login) |
| Signed in, policy fails | Scheme forbid (e.g. redirect to access denied) |

SharPress has no login page. Use the app's. Put it outside `BaseUrl` or allow anonymous access to it.
