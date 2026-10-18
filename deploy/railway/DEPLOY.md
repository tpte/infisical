# Deploy `tpte/infisical` on Railway

Fork 含 **zh-TW** 語系（個人設定 → 一般 → 變更語言）。Docker 建置完整 standalone 映像，耗時與記憶體需求較高。

## 1. 建立 Railway 專案

1. [Railway](https://railway.com) → New Project  
2. **Add PostgreSQL**、**Add Redis**  
3. **New Service** → Deploy from GitHub → `tpte/infisical`（此 fork）  
4. 該 service 會讀取根目錄 `railway.toml`，使用 `Dockerfile.standalone-infisical` 建置  

## 2. 環境變數（Infisical service）

在 Infisical **web service** 設定（勿提交 repo）：

| 變數 | 值 |
|------|-----|
| `NODE_ENV` | `production` |
| `ENCRYPTION_KEY` | 32 字元 hex（自行產生，勿用 `.env.example` 範例） |
| `AUTH_SECRET` | 長隨機字串（例：`openssl rand -base64 32`） |
| `DB_CONNECTION_URI` | 參考 Postgres service 的 `DATABASE_URL`（格式需為 `postgres://...`） |
| `REDIS_URL` | Redis service 的連線 URL |
| `SITE_URL` | `https://<你的-railway-域名>`（**必須**與對外 URL 一致） |
| `PORT` | Railway 通常自動注入；映像預設 `8080` |

Postgres 若只提供 `DATABASE_URL`，在 Infisical service 新增：

```bash
DB_CONNECTION_URI=${{Postgres.DATABASE_URL}}
```

（變數參考語法依 Railway 當前 UI 為準。）

## 3. 公開網域

Infisical service → Settings → Networking → Generate Domain。  
將產生的 HTTPS URL 設為 `SITE_URL`，重新 deploy。

## 4. 驗收

- `https://<domain>/api/status` 回 200  
- 註冊管理員 → **Personal Settings → General → 變更語言 → 繁體中文（台灣）**

## 5. 限制

- 首次 Docker build 可能 **15–30+ 分鐘**（frontend + backend）。  
- 免費方案可能 OOM；必要時升級 plan 或改用官方 `infisical/infisical` 映像 + 僅 fork 前端 locale（進階）。  
- 大部分 UI 仍為英文；僅 `react-i18next` 有接的字串會顯示 zh-TW。
