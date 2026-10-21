# Run Infisical docker compose inside WSL Ubuntu (no Docker Desktop required).
$ErrorActionPreference = "Stop"
$Distro = "Ubuntu-24.04"
$WinRepo = "C:\Users\owzpk\infisical"
$WslRepo = "/home/owzpk/infisical"

if (-not (Test-Path $WinRepo)) {
  Write-Error "Repo not found: $WinRepo"
}

wsl -d $Distro -u owzpk -- bash -lc @"
set -euo pipefail
cd '$WslRepo'
if ! systemctl is-active --quiet docker; then
  echo 'Docker not active in WSL. Run: wsl -d $Distro -u root -- systemctl start docker' >&2
  exit 1
fi
docker compose -f docker-compose.prod.yml -f deploy/msi-cloudflare/docker-compose.msi.override.yml up -d
echo 'Local (MSI): http://127.0.0.1:80'
"@
