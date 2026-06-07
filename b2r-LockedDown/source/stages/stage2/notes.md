# Stage 2 — Lateral Movement to mitchel

mitchel is locked by default at container startup via `passwd -l mitchel`.

Jake unlocks her using the sudo passwd rule:
```sh
sudo passwd -u mitchel
```

Credentials for mitchel are found in /opt/Book1.xlsx on the box.
Login: `mitchel : sZus5bpFphyq`
