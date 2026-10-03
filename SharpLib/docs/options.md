# Options

Set in code. Everything is optional.

```csharp
builder.AddSharPress(options =>
{
    options.RootFolder = "Content";
    options.DocsUrl = "guide";
});
```

Also available as `builder.Services.AddSharPress(...)`.

| Option | Default | Description |
| ------ | ------- | ----------- |
| `RootFolder` | `"SharpLib"` | Site folder. Relative to the content root, or absolute |
| `DocsFolder` | `"docs"` | Pages folder, inside `RootFolder`. Disk only, not the URL |
| `StaticFolder` | `"public"` | Served from the site root, inside `RootFolder`. Always created |
| `IndexFile` | `"Index.md"` | Home page, inside `RootFolder` |
| `SettingsFile` | `"sharpress.json"` | Settings, inside `RootFolder` |
| `CustomCssFile` | `"custom.css"` | Inside `StaticFolder`. Linked only if it exists |
| `BaseUrl` | `""` | URL prefix for the whole site. See [URLs](/docs/urls#baseurl) |
| `DocsUrl` | `"docs"` | URL prefix for pages, inside `BaseUrl`. `""` = root. See [URLs](/docs/urls#docsurl) |
| `CreateStarterFiles` | `true` | Create a starter site on first run |
| `RequireAuthorization` | `false` | Require an authorized user. See [Sign-in](/docs/authorization) |
| `AuthorizationPolicy` | `null` | Named policy. Setting it implies `RequireAuthorization` |

## Starter files

With `CreateStarterFiles = true`, startup creates only what's missing and never overwrites:

| Item | Created when |
| ---- | ------------ |
| `sharpress.json` | File missing |
| `Index.md` | Together with `sharpress.json` only (new site) |
| Starter pages | `DocsFolder` missing |
| Logo, favicon, `custom.css` | `StaticFolder` missing |

No starter files are created with a [custom content source](/docs/content-sources).

> A deployment without `DocsFolder` gets the starter pages. See [Deployment](/docs/deployment#publish-sharplib).
