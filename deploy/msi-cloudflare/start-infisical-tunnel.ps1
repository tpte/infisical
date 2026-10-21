# Run named tunnel infisical-msi (separate from vip104-home / config.yml)
$ErrorActionPreference = "Stop"
$Cf = "C:\Program Files (x86)\cloudflared\cloudflared.exe"
$Cfg = "$env:USERPROFILE\.cloudflared\infisical-config.yml"
$Log = "$env:USERPROFILE\.cloudflared\infisical-tunnel.log"

if (-not (Test-Path $Cfg)) {
  Write-Error "Missing $Cfg — copy from deploy/msi-cloudflare/infisical-config.yml.example"
}

$existing = Get-CimInstance Win32_Process -Filter "Name='cloudflared.exe'" -ErrorAction SilentlyContinue |
  Where-Object { $_.CommandLine -match "infisical-config\.yml" }
if ($existing) {
  Write-Host "Infisical tunnel already running (PID $($existing.ProcessId))"
  exit 0
}

$cmd = @"
start "" /B "$Cf" --config "$Cfg" --logfile "$Log" --loglevel info --no-autoupdate tunnel run infisical-msi
"@
cmd.exe /c $cmd | Out-Null
Start-Sleep -Seconds 2
$proc = Get-CimInstance Win32_Process -Filter "Name='cloudflared.exe'" -ErrorAction SilentlyContinue |
  Where-Object { $_.CommandLine -match "infisical-config\.yml" }
if (-not $proc) {
  Write-Error "infisical-msi cloudflared did not stay running; see $Log"
}
Write-Host "Started infisical-msi tunnel (PID $($proc.ProcessId)); log: $Log"
