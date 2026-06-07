FROM alpine:3.23

# ── Dependencies ──────────────────────────────────────────────────────────────
RUN apk add --no-cache \
    openssh \
    sudo \
    vim \
    gcc \
    musl-dev \
    shadow \
    curl

# ── Copy base files ───────────────────────────────────────────────────────────
COPY stages/base/readfile.c   /tmp/readfile.c
COPY stages/base/todolist.txt /tmp/todolist.txt
COPY stages/base/sshd_config  /tmp/sshd_config
COPY flag.txt                 /tmp/flag.txt

COPY stages/base/Book1.xlsx   /tmp/Book1.xlsx

# ── Copy and run setup ────────────────────────────────────────────────────────
COPY deploy/config/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh && sh /tmp/setup.sh

# ── Generate SSH host keys ────────────────────────────────────────────────────
RUN ssh-keygen -A

# ── Entrypoint ────────────────────────────────────────────────────────────────
COPY deploy/config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
