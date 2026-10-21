# NEW Cloudflare quick tunnel — separate process, does NOT edit config.yml (vip104-proxy).
$ErrorActionPreference = "Stop"
$LogDir = "C:\Users\owzpk\infisical\cloudflared-infisical"
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
$Log = Join-Path $LogDir "quick-tunnel.log"

$cf = "C:\Program Files (x86)\cloudflared\cloudflared.exe"
if (-not (Test-Path $cf)) { $cf = "cloudflared" }

Write-Host "Starting quick tunnel -> http://127.0.0.1:80 (log: $Log)"
Write-Host "Uses --config NUL so hi-yen config.yml is not loaded."
Write-Host "After URL appears, set SITE_URL in .env to that https URL and restart backend."

Start-Process -FilePath $cf -ArgumentList @(
  "tunnel", "--config", "NUL", "--url", "http://127.0.0.1:80",
  "--logfile", $Log, "--loglevel", "info", "--metrics", "127.0.0.1:20243"
) -WindowStyle Hidden
Start-Sleep -Seconds 8
Get-Content $Log -Tail 30
