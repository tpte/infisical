# Named tunnel infisical-msi + infisical-config.yml (never modifies config.yml / vip104-home)
$ErrorActionPreference = "Stop"
$CfDir = "$env:USERPROFILE\.cloudflared"
$Name = "infisical-msi"
$Cf = "C:\Program Files (x86)\cloudflared\cloudflared.exe"
$Cfg = Join-Path $CfDir "infisical-config.yml"
$Example = "C:\Users\owzpk\infisical\deploy\msi-cloudflare\infisical-config.yml.example"
$Hostname = "infisical-vault.hi-yen.com"

if (-not (Test-Path $Cfg)) {
  if (-not (Test-Path $Example)) {
    Write-Error "Missing $Example"
  }
  Copy-Item $Example $Cfg
  Write-Host "Copied example config to $Cfg — edit tunnel/credentials if tunnel id differs."
}

$existing = & $Cf tunnel list 2>$null | Select-String $Name
if (-not $existing) {
  & $Cf tunnel create $Name
}

& $Cf --config $Cfg tunnel route dns a2e6bbec $Hostname
Write-Host "DNS: https://$Hostname -> tunnel infisical-msi (use --config infisical-config.yml for route dns)"
Write-Host "Start: deploy\msi-cloudflare\start-infisical-tunnel.ps1"
Write-Host "SITE_URL=https://$Hostname then restart backend."
