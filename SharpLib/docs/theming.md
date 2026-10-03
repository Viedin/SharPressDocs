# Theming

Override styles in `SharpLib/public/custom.css`. It's loaded after the built-in stylesheet.

```css
:root {
  --sp-brand: #0f766e;
}

:root[data-theme="dark"] {
  --sp-brand: #5eead4;
}
```

## Color variables

| Variable | Light | Dark |
| -------- | ----- | ---- |
| `--sp-brand` | `#3451b2` | `#a8b1ff` |
| `--sp-bg` | `#ffffff` | `#1b1b1f` |
| `--sp-bg-soft` | `#f6f6f7` | `#202127` |
| `--sp-text` | `#3c3c43` | `#dfdfd6` |
| `--sp-heading` | `#213547` | `#ffffff` |
| `--sp-border` | `#e2e2e3` | `#2e2e32` |
| `--sp-code-bg` | `#f6f6f7` | `#161618` |

## Syntax highlighting variables

GitHub light/dark by default.

`--sp-hl-keyword` `--sp-hl-title` `--sp-hl-constant` `--sp-hl-string` `--sp-hl-built-in` `--sp-hl-comment`
`--sp-hl-tag` `--sp-hl-section` `--sp-hl-bullet` `--sp-hl-addition` `--sp-hl-addition-bg` `--sp-hl-deletion`
`--sp-hl-deletion-bg`

## Dark mode

- Theme = `data-theme="light|dark"` on `<html>`.
- Default follows `prefers-color-scheme`.
- The toggle stores the choice in `localStorage` (`sp-theme`), which then overrides the system setting.

## Classes

All built-in classes are prefixed `sp-`.

| Class | Element |
| ----- | ------- |
| `.sp-sidebar` `.sp-nav` | Sidebar |
| `.sp-nav-title` `.sp-nav-logo` | Site title and logo |
| `.sp-nav-group` `.sp-nav-group-title` | Sidebar group |
| `.sp-doc` | Page content |
| `.sp-aside` `.sp-toc` | On this page |
| `.sp-neighbours` | Prev/next links |
| `.sp-hero` `.sp-hero-name` `.sp-hero-text` `.sp-hero-tagline` | Home hero |
| `.sp-button-brand` `.sp-button-alt` | Hero buttons |
| `.sp-features` `.sp-feature` | Feature cards |
| `.sp-theme-toggle` | Theme button |
| `.sp-topbar` | Mobile menu bar |

```css
.sp-doc { max-width: 900px; }
```

SharPress is in preview; class names may change between releases.

## Layout breakpoints

| Width | Layout |
| ----- | ------ |
| < 800px | Sidebar becomes a drawer behind a **Menu** button |
| ≥ 1100px | **On this page** outline shown |
