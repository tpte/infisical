$CfCfg = "$env:USERPROFILE\.cloudflared\infisical-config.yml"
$running = Get-CimInstance Win32_Process -Filter "Name='cloudflared.exe'" -ErrorAction SilentlyContinue |
  Where-Object { $_.CommandLine -match [regex]::Escape($CfCfg) }
if (-not $running) {
  & "$PSScriptRoot\start-infisical-tunnel.ps1"
}
