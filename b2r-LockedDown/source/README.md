# Assumed Breach — Maintainer Notes

## Challenge Summary

SSH-based boot2root with three privilege escalation stages.

**Stage 1 — Enumeration as jake**
- SSH in as jake (credentials given)
- `id` reveals jake is in `it` group
- `sudo -l` reveals jake can lock/unlock users via passwd
- `todolist.txt` hints at locking all accounts
- `/opt/Book1.xlsx` contains credentials for all users

**Stage 2 — Lateral movement to mitchel**
- mitchel is in `itAdmin` group and is locked by default
- Jake unlocks mitchel: `sudo passwd -u mitchel`
- Log in as mitchel using credentials from Book1.xlsx

**Stage 3 — Root via sudo readfile → vi escape**
- `sudo -l` as mitchel reveals: `sudo /usr/bin/readfile /home/jake/todolist.txt`
- `readfile` invokes `vi` internally (XOR obfuscated)
- vi shell escape: `:!/bin/sh` → root shell
- Flag at `/root/flag.txt`

## Directory Layout

```
stages/base/     readfile.c source, sshd_config, todolist.txt
stages/stage1/   User/group creation and sudo rules
stages/stage2/   mitchel account locked by default
stages/stage3/   readfile binary compilation and placement
deploy/          Docker runtime
solve/           Reference solution
```

## Notes

- Book1.xlsx must be manually downloaded from Google Drive and placed at:
  `source/stages/base/Book1.xlsx`
- SSH is password-only, no key auth, sshd_config readable by root only
- mitchel is locked at container start — jake must unlock as part of the challenge
- `nc` and `wget` are NOT removed in this challenge (different box from b2r-node)
