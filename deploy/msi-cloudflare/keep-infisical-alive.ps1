# Keep WSL Infisical origin reachable for infisical-msi named tunnel (does not touch config.yml).
$ErrorActionPreference = "SilentlyContinue"
$Distro = "Ubuntu-24.04"
wsl -d $Distro -u root -- systemctl start docker 2>$null | Out-Null
wsl -d $Distro -u owzpk -- bash -lc "cd ~/infisical && docker compose -f docker-compose.prod.yml -f deploy/msi-cloudflare/docker-compose.msi.override.yml up -d" 2>$null | Out-Null
& "$PSScriptRoot\check-infisical-tunnel.ps1"
