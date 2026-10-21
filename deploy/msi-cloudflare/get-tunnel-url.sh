#!/usr/bin/env bash
grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' "${HOME}/infisical/cloudflared-infisical/wsl-quick-tunnel.log" | tail -1
