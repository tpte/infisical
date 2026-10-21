# Infisical on MSI — docker compose (does not touch hi-yen cloudflared config)
$ErrorActionPreference = "Stop"
$Repo = "C:\Users\owzpk\infisical"
Set-Location $Repo

$wslDocker = wsl -d Ubuntu-24.04 -u owzpk -- docker info 2>$null
if ($LASTEXITCODE -eq 0) {
  & "$PSScriptRoot\msi-wsl-docker.ps1"
  exit $LASTEXITCODE
}

docker info | Out-Null
if ($LASTEXITCODE -ne 0) {
  Write-Error "No Docker: start WSL Ubuntu docker (systemctl) or Docker Desktop, then re-run."
}

docker compose -f docker-compose.prod.yml up -d
Write-Host "Local: http://127.0.0.1:80  (health: http://127.0.0.1/api/status)"
