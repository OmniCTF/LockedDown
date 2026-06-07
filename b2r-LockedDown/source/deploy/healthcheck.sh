#!/bin/sh
# healthcheck.sh — validates SSH is reachable

TARGET="${1:-localhost}"
PORT="${2:-2222}"

echo "[*] Checking SSH on ${TARGET}:${PORT}..."

if nc -z -w 5 "$TARGET" "$PORT" 2>/dev/null; then
    echo "[+] SSH is UP on ${TARGET}:${PORT}"
    exit 0
else
    # fallback using curl if nc unavailable
    if curl -s --connect-timeout 5 "ssh://${TARGET}:${PORT}" 2>&1 | grep -q "SSH"; then
        echo "[+] SSH is UP on ${TARGET}:${PORT}"
        exit 0
    fi
    echo "[-] SSH is not reachable on ${TARGET}:${PORT}"
    exit 1
fi
