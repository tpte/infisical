# Register logon task to keep infisical-msi cloudflared running (does not touch vip104-home).
$ErrorActionPreference = "Stop"
$Repo = "C:\Users\owzpk\infisical\deploy\msi-cloudflare"
$Check = Join-Path $Repo "check-infisical-tunnel.ps1"
$TaskName = "InfisicalCloudflaredTunnel"

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$Check`""
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Settings $settings -Force | Out-Null
Write-Host "Registered scheduled task: $TaskName"
