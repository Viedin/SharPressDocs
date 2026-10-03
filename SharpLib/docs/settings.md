# sharpress.json

Site settings, in `SharpLib/sharpress.json`. Read per request.

- All properties optional. Missing file = defaults.
- Property names are case-insensitive.
- Comments and trailing commas allowed.
- Invalid JSON: warning logged, defaults used.

```json
{
  "title": "Acme Docs",
  "logo": "/logo.svg",
  "favicon": "/favicon.svg",
  "sidebarTitle": "Documentation",
  "sidebar": [
    {
      "text": "Guide",
      "items": [
        { "link": "/docs/getting-started" },
        { "link": "/docs/install", "text": "Installing" }
      ]
    }
  ],
  "home": {
    "hero": {
      "image": "/logo.svg",
      "name": "Acme",
      "text": "Integrate with Acme.",
      "tagline": "Guides and reference.",
      "actions": [
        { "text": "Get started", "link": "/docs/getting-started" },
        { "text": "GitHub", "link": "https://github.com/acme", "theme": "alt" }
      ]
    },
    "features": [
      { "icon": "rocket-takeoff", "title": "Quick start", "details": "Five minutes.", "link": "/docs/getting-started" }
    ]
  }
}
```

## Links

Applies to every `link`, `logo`, `favicon` and `image`.

| Value | Resolves to |
| ----- | ----------- |
| `/docs/x` or `docs/x` | Site-root URL, prefixed with path base and `BaseUrl` |
| `https://...`, `mailto:...` | Unchanged |
| `#id` | Unchanged |

## Site

| Property | Type | Description |
| -------- | ---- | ----------- |
| `title` | string | Shown at the top of the sidebar. Links home if there is a home page |
| `logo` | string | Image next to the title |
| `favicon` | string | Browser tab icon |
| `sidebarTitle` | string | Label above the sidebar groups |
| `sidebar` | array | See [sidebar](#sidebar) |
| `home` | object | See [home](#home) |

## sidebar

| Property | Type | Description |
| -------- | ---- | ----------- |
| `text` | string | Group heading, or link text. Links default to the page's `#` title |
| `link` | string | Page URL or external URL |
| `items` | array | Makes the entry a group |

- Render order = array order. Prev/next links follow the same order across groups.
- External links are excluded from prev/next.
- Adjacent top-level links share one untitled group.
- Nested groups are flattened into the parent.
- Empty or missing: every page, sorted by path, no headings.
- Development only: a warning is logged once per link that matches no page or static file.

## home

Landing section above `Index.md`. Omit for none.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `hero.image` | string | Image above the headline |
| `hero.name` | string | Headline, brand color |
| `hero.text` | string | Second line |
| `hero.tagline` | string | Smaller supporting line |
| `hero.actions[].text` | string | Button label |
| `hero.actions[].link` | string | Button target. No link = button hidden |
| `hero.actions[].theme` | string | `brand` (default, filled) or `alt` (outlined) |
| `features[].icon` | string | [Bootstrap Icons](https://icons.getbootstrap.com/) name without `bi-`. Bundled, no CDN |
| `features[].title` | string | Card heading |
| `features[].details` | string | Card text |
| `features[].link` | string | Makes the whole card a link |

### Home page rules

| `Index.md` | `home` | `/` |
| ---------- | ------ | --- |
| yes | any | Home page |
| no | yes | Home page with landing section only |
| no | no | Redirects to the first existing sidebar page. Site title is not a link. Not in sitemap |

`Index.md` is never recreated once deleted. No outline or sidebar is shown on the home page.

## From code

A [content source](/docs/content-sources) returns the same data as `SiteSettings` (`SharPress.Services`):

```csharp
new SiteSettings
{
    Title = "Acme Docs",
    Sidebar = [new SidebarItem { Text = "Guide", Items = [new SidebarItem { Link = "/docs/getting-started" }] }],
    Home = new HomeSettings { Hero = new HeroSettings { Name = "Acme" } },
};
```

Types: `SiteSettings`, `SidebarItem`, `HomeSettings`, `HeroSettings`, `HeroAction`, `FeatureItem`.
