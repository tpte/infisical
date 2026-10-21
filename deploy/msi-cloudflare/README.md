# Infisical on MSI + 獨立 Cloudflare Tunnel（1C）

- **不修改** `C:\Users\owzpk\.cloudflared\config.yml`（vip104-proxy / hi-yen）。
- **Quick 測試**：`start-quick-tunnel.ps1` → `*.trycloudflare.com`（獨立 cloudflared 行程）。
- **現況（Tailscale only，不用 hi-yen）**：Mac Safari 用 `http://127.0.0.1:18080/`（`ssh -L 18080:127.0.0.1:80 msi`）。直連可試 `http://msi:8080/`（portproxy）。細節見 `tailscale-notes.txt`。
- **Named / quick tunnel**：可選；**不要**再把 Infisical Public Hostname 掛在 `hi-yen.com`。

## MSI 上已有

- Repo：`C:\Users\owzpk\infisical`（`tpte/infisical`）
- `.env`（本機 scp，含新 `ENCRYPTION_KEY` / `AUTH_SECRET`）

## WSL2 + Docker Engine（建議）

- Distro：`Ubuntu-24.04`，`/etc/wsl.conf` 已設 `systemd=true`，user `owzpk` 在 `docker` group。
- **Compose 路徑**：`~/infisical`（WSL 原生 ext4，勿在 `/mnt/c` 跑 compose）。
- **關閉 Docker Desktop**（保留 WSL Engine 即可；Desktop 與 WSL dockerd 並存時可能反覆重啟 docker.service）。
- 遠端起 Infisical：`msi-wsl-docker.ps1` 或 `msi-up.ps1`（會優先用 WSL Docker）。
- **Image**：override 暫 pin `infisical/infisical:v0.154.6`（`latest` 首次 migration 在 MSI 上易失敗）；fork 自架 image／修 migration 後再改 tag。

## 順序（在 MSI PowerShell）

1. 確認 WSL Docker：`wsl -d Ubuntu-24.04 -u owzpk -- docker info`（或開 Docker Desktop 當 fallback）。
2. `powershell -ExecutionPolicy Bypass -File C:\Users\owzpk\infisical\deploy\msi-cloudflare\msi-up.ps1`
3. `powershell -ExecutionPolicy Bypass -File ...\start-quick-tunnel.ps1` → 記 log 裡的 `https://….trycloudflare.com`
4. 把 `.env` 的 `SITE_URL` 改成該 URL → `docker compose -f docker-compose.prod.yml restart backend`
5. Mac 外網用瀏覽器開同一 URL（建議之後加 Cloudflare Access）

## Mac 一鍵（需 Docker 已在 MSI 跑起來）

```bash
ssh msi 'powershell -ExecutionPolicy Bypass -File C:/Users/owzpk/infisical/deploy/msi-cloudflare/msi-up.ps1'
```
