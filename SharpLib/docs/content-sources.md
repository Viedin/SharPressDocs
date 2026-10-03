# Content sources

Replace the file-based source to read pages and settings from a database, CMS or API.

```csharp
builder.AddSharPress();
builder.AddSharPressContentSource<DbContentSource>(); // before or after AddSharPress
```

## Interface

```csharp
public interface ISharPressContentSource
{
    Task<string?> GetHomePageAsync(CancellationToken ct);               // null = no home page
    Task<bool> HasHomePageAsync(CancellationToken ct);                  // default: GetHomePageAsync != null
    Task<string?> GetDocsPageAsync(string slug, CancellationToken ct);  // null = 404
    Task<IReadOnlyList<DocsPageEntry>> GetDocsPagesAsync(CancellationToken ct);
    Task<SiteSettings?> GetSettingsAsync(CancellationToken ct);         // null = defaults
}

public sealed record DocsPageEntry(string Slug, string? Title);
```

| Type | Namespace |
| ---- | --------- |
| `ISharPressContentSource`, `DocsPageEntry` | `SharPress` |
| `SiteSettings` and children | `SharPress.Services` |

## Slugs

Path under `DocsUrl`, no leading/trailing slash: `getting-started`, `guide/install`.

- `GetDocsPageAsync` receives the slug lower-cased.
- Slugs from `GetDocsPagesAsync` are lower-cased by SharPress.
- `Title = null` falls back to the last slug segment, dashes as spaces.

## Example (EF Core)

```csharp
using Microsoft.EntityFrameworkCore;
using SharPress;
using SharPress.Services;

public sealed class DbContentSource(DocsDbContext db) : ISharPressContentSource
{
    public Task<string?> GetHomePageAsync(CancellationToken ct) =>
        db.Pages.Where(p => p.IsHome).Select(p => p.Markdown).FirstOrDefaultAsync(ct);

    public Task<bool> HasHomePageAsync(CancellationToken ct) =>
        db.Pages.AnyAsync(p => p.IsHome, ct);

    public Task<string?> GetDocsPageAsync(string slug, CancellationToken ct) =>
        db.Pages.Where(p => p.Slug == slug).Select(p => p.Markdown).FirstOrDefaultAsync(ct);

    // Called on every page view. Don't load content here.
    public async Task<IReadOnlyList<DocsPageEntry>> GetDocsPagesAsync(CancellationToken ct) =>
        await db.Pages.Where(p => !p.IsHome).Select(p => new DocsPageEntry(p.Slug, p.Title)).ToListAsync(ct);

    public Task<SiteSettings?> GetSettingsAsync(CancellationToken ct) =>
        Task.FromResult<SiteSettings?>(new SiteSettings { Title = "Acme Docs" });
}
```

Settings shape: [sharpress.json → From code](/docs/settings#from-code).

## Lifetime

Scoped by default (can use `DbContext`). Override:

```csharp
builder.AddSharPressContentSource<CmsContentSource>(ServiceLifetime.Singleton);
```

## Calls per docs page view

| Method | Calls |
| ------ | ----- |
| `GetSettingsAsync` | 1 (cached per request) |
| `GetDocsPagesAsync` | 1+ |
| `GetDocsPageAsync` | 1 |
| `HasHomePageAsync` | 1 |

SharPress caches nothing across requests. Cache in the source if needed, e.g. with `HybridCache`.

## Notes

- `public/` is still served from disk.
- No starter files are created.
- Markdown HTML is not sanitized. Sanitize untrusted content in the source.
