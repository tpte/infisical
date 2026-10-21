@echo off
"C:\Program Files (x86)\cloudflared\cloudflared.exe" --config "C:\Users\owzpk\.cloudflared\infisical-config.yml" --logfile "C:\Users\owzpk\.cloudflared\infisical-tunnel.log" --loglevel info --no-autoupdate tunnel run infisical-msi
