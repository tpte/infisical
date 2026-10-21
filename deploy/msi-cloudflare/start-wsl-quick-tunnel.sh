#!/usr/bin/env bash
set -euo pipefail
LOG_DIR="${HOME}/infisical/cloudflared-infisical"
LOG="${LOG_DIR}/wsl-quick-tunnel.log"
mkdir -p "$LOG_DIR"
pkill -f 'cloudflared tunnel --url http://127.0.0.1:80' 2>/dev/null || true
nohup cloudflared tunnel --url http://127.0.0.1:80 --loglevel info >"$LOG" 2>&1 &
sleep 10
grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' "$LOG" | tail -1
