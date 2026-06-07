# Deployment Guide — Assumed Breach

## Prerequisites

- Docker + Docker Compose installed

## Build and Run

```sh
cd source/deploy
docker-compose up --build -d
```

## Verify

```sh
# Container running
docker ps | grep ctf-assumed-breach

# SSH reachable
sh healthcheck.sh <host_ip>

# Test login as jake
ssh jake@<host_ip> -p 2222
# password: 2eEhVmkzMHTq

# Confirm mitchel is locked
docker exec ctf-assumed-breach passwd -S mitchel
# → mitchel L (L = locked)

# Confirm flag is in place
docker exec ctf-assumed-breach ls -la /root/flag.txt
# → -r--------  root  root  flag.txt
```

## Hosting Multiple Instances

Change the host port in `docker-compose.yml`:

```yaml
ports:
  - "2223:22"   # different port per instance
```

## Reset

```sh
docker-compose down
docker-compose up -d
```
