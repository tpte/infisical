@echo off
tasklist /FI "IMAGENAME eq cloudflared.exe" | find /I "infisical-config.yml" >nul
if errorlevel 1 (
  start "" /B "C:\Users\owzpk\infisical\deploy\msi-cloudflare\start-infisical-tunnel.cmd"
)
