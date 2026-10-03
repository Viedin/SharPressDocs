# Pages

Each `.md` file in `SharpLib/docs` is a page. Path without `.md` = URL.

| File | URL |
| ---- | --- |
| `docs/getting-started.md` | `/docs/getting-started` |
| `docs/guides/install.md` | `/docs/guides/install` |

- URLs are case-insensitive on every OS.
- Unknown URL: **Page not found**, status `404`.
- Non-`.md` files in `docs/` aren't served. Put assets in [`public/`](/docs/static-files).

## Title

First `#` heading. Used for the browser tab, the sidebar (unless `text` is set) and prev/next links.

No `#` heading: last segment of the file name, dashes as spaces (`my-page.md` → `my page`).

## Outline

`##` and `###` headings are listed under **On this page**. Heading ids are GitHub-style: `## Page titles` →
`#page-titles`.

## Links

```markdown
[Theming](/docs/theming)
[Color variables](/docs/theming#color-variables)
```

Links starting with `/` are site-root links. SharPress prefixes them with the path base and `BaseUrl`, so they
work wherever the site is hosted. Prefer them over relative links.

External links, `mailto:` and `#anchors` are left unchanged.

## Markdown

[Markdig](https://github.com/xoofx/markdig) with advanced extensions (GitHub-style tables, task lists,
footnotes, attributes, ...).

- Code blocks are highlighted when the fence names a language supported by the bundled highlight.js: `csharp`,
  `vbnet`, `html`/`xml`, `css`, `js`, `ts`, `json`, `yaml`, `ini`, `bash`, `shell`, `sql`, `graphql`,
  `markdown`, `diff`, `c`, `cpp`, `go`, `rust`, `java`, `kotlin`, `swift`, `python`, `ruby`, `php`, and a few
  more. Others (e.g. `powershell`) render plain.
- Raw HTML is passed through unsanitized.

## Reload behavior

Everything is read per request. Nothing is cached.

| Change | Effect |
| ------ | ------ |
| Edit a page | Next refresh |
| Add/rename a page | Sidebar and sitemap update on next refresh |
| Edit `sharpress.json` | Next refresh. Invalid JSON: warning logged, defaults used |
| Edit `custom.css` | Next refresh. URL is versioned by file timestamp |

## Sidebar

Pages not in the `sidebar` setting still work but have no prev/next links. See
[sharpress.json](/docs/settings#sidebar).
