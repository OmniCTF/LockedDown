#!/bin/sh
set -e
echo "[*] Starting Assumed Breach CTF challenge..."
exec /usr/sbin/sshd -D -e
