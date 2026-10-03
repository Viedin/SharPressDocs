## Quick start

```bash
dotnet add package SharPress --prerelease
```

```csharp
using SharPress;

var builder = WebApplication.CreateBuilder(args);
builder.AddSharPress();

var app = builder.Build();
app.UseSharPress();
app.Run();
```

First run creates `SharpLib/` with a starter site. Docs are served at `/docs/getting-started`.

## Requirements

- .NET 10 or later, ASP.NET Core
- Native AOT works, with trim/AOT warnings. See [Deployment](/docs/deployment#native-aot)

MIT licensed. This site is built with SharPress.
