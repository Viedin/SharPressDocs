# Static files

`SharpLib/public` is served from the site root.

| File | URL |
| ---- | --- |
| `public/logo.svg` | `/logo.svg` |
| `public/images/a.png` | `/images/a.png` |
| `public/docs/guides/b.png` | `/docs/guides/b.png` |

```markdown
![Diagram](/images/a.png)
```

- `/` paths get the path base and `BaseUrl` prepended.
- A file under the docs URL wins over a page with the same path.
- Only known content types are served (same rule as `UseStaticFiles`).
- Paths can't escape the folder.
- Protected when [sign-in is required](/docs/authorization).
- Still served from disk with a [custom content source](/docs/content-sources).

## Special files

| File | Purpose |
| ---- | ------- |
| `custom.css` | Loaded after built-in styles. See [Theming](/docs/theming) |
| `sitemap.xml` | Replaces the generated sitemap |
| `robots.txt` | Served as is |
| Logo, favicon | Referenced from [`sharpress.json`](/docs/settings#site) |

Folder name: `StaticFolder`. CSS file name: `CustomCssFile`. See [Options](/docs/options).
