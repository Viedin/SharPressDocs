# SharPress Docs

Documentation site for [SharPress](https://github.com/Viedin/SharPress), built with SharPress and deployed as a
native AOT Docker image (~18 MB compressed).

Content lives in `SharpLib/`: pages in `docs/`, settings in `sharpress.json`.

## Run locally

```bash
dotnet run
```

## Deploy

Native AOT Docker image behind a Cloudflare Tunnel.

```bash
cp .env.example .env   # set TUNNEL_TOKEN
docker compose up -d --build
```

Point the tunnel's public hostname to `http://docs:8080`.
