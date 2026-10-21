# Ping Ubuntu so WSL idle terminate does not poweroff Infisical's docker.
$ErrorActionPreference = "SilentlyContinue"
$Distro = "Ubuntu-24.04"
wsl --set-default $Distro 2>$null | Out-Null
wsl -d $Distro -- true 2>$null | Out-Null
$alive = Get-CimInstance Win32_Process -Filter "Name='wsl.exe'" -ErrorAction SilentlyContinue |
  Where-Object { $_.CommandLine -match "sleep infinity" -and $_.CommandLine -match $Distro }
if (-not $alive) {
  Start-Process -FilePath "wsl.exe" -ArgumentList @("-d", $Distro, "--", "sleep", "infinity") -WindowStyle Hidden
}
wsl -d $Distro -u root -- systemctl start docker 2>$null | Out-Null
