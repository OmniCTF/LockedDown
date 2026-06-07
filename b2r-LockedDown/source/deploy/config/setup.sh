#!/bin/sh
# setup.sh - Full CTF environment setup
set -e

# ── Groups ────────────────────────────────────────────────────────────────────
for g in finance hr marketing sales executive guest it itAdmin; do
    addgroup -S "$g" 2>/dev/null || true
done

# ── Create user helper ────────────────────────────────────────────────────────
create_user() {
    USERNAME="$1"
    PASSWORD="$2"
    GROUP="$3"
    adduser -D -s /bin/sh -G "$GROUP" "$USERNAME" 2>/dev/null || true
    echo "$USERNAME:$PASSWORD" | chpasswd
}

# ── General users ─────────────────────────────────────────────────────────────
create_user aaron     "K9!mV3#pL7@x"     finance
create_user adrian    "T4@qZ8!nW2#r"     hr
create_user aiden     "M7#vX1@kP9!s"     marketing
create_user alec      "R8!jN4#yT6@w"     sales
create_user andrew    "P3@dK7!mQ1#x"     executive
create_user anthony   "W6#tH2@vL8!n"     guest
create_user benjamin  "Y9!pC5#rF3@k"     finance
create_user blake     "N4@xJ8!qM7#t"     hr
create_user brandon   "H2#wP9@dR4!y"     marketing
create_user caleb     "V7!mT3#kZ1@p"     sales
create_user cameron   "Q5@nL8!xH6#r"     executive
create_user christian "K1#yW4@pN9!m"     guest
create_user connor    "F8!rD2#tQ7@v"     finance
create_user daniel    "X3@kM6!wP5#n"     hr
create_user dylan     "T9#pV1@jR8!k"     marketing
create_user ethan     "L4!xQ7#mH2@w"     sales
create_user gabriel   "M8@rK3!yT6#p"     executive
create_user gavin     "P1#nW5@vX9!d"     guest
create_user isaac     "R6!kH2#qL4@t"     finance
create_user jason     "N7@wP8!mD3#x"     hr
create_user jordan    "V2#tX6@rK1!p"     marketing
create_user joshua    "H9!mQ4#yW7@n"     sales
create_user justin    "F3@pL8!kR5#v"     executive
create_user kevin     "Y1#xT7@nM4!q"     guest
create_user liam      "K6!rV2#pH9@w"     finance
create_user logan     "Q8@mD1!xP3#t"     hr
create_user marcus    "W4#kN9@yR6!p"     marketing
create_user mason     "T2!vL7#qX8@m"     sales
create_user nathan    "P5@rH3!wK1#y"     executive
create_user noah      "X7#mQ4@tV9!n"     guest
create_user oliver    "M1!pD8#kR2@w"     finance
create_user ryan      "L9@xW5!nT6#q"     hr
create_user samuel    "H4#rP7@yM3!v"     marketing
create_user tyler     "V8!kQ2#mL1@t"     sales
create_user zachary   "N3@wX9!pH5#r"     executive
create_user bobby     "rtaK6QzwvRdG"     guest
create_user allison   "kJbH787WnVUf"     guest
create_user lux       "YGsQzkuQxEUh"     guest
create_user alice     "H@rdW0rk!2025xQ"  hr
create_user bob       "P3rs0nn3l#Zk91!"  hr
create_user carol     "Br@nd1ng\$Kw47!"  marketing
create_user dave      "Camp@1gn#Lx83!"   marketing
create_user eve       "M3d1a\$Tr3nd!Pq2" marketing
create_user frank     "Qu0ta\$H1t!Zr56"  sales
create_user grace     "D3al\$C10s3d!Nm8" sales
create_user henry     "R3v3nu3!Gx74#Wq"  sales
create_user irene     "Budg3t\$Xk92!Lp"  finance
create_user jack      "Aud1t#Tr41l!Yz3"  finance

# ── jake and mitchel — must be created before any chown ──────────────────────
create_user jake    "2eEhVmkzMHTq" it
create_user mitchel "sZus5bpFphyq" itAdmin

# Lock mitchel by default
passwd -l mitchel

# ── jake's home files — after user exists ─────────────────────────────────────
mkdir -p /home/jake
cp /tmp/todolist.txt /home/jake/todolist.txt
chown "$(id -u jake):$(id -g jake)" /home/jake/todolist.txt
chmod 0644 /home/jake/todolist.txt

# ── Book1.xlsx in /opt ────────────────────────────────────────────────────────
cp /tmp/Book1.xlsx /opt/Book1.xlsx 2>/dev/null || true
chmod 0644 /opt/Book1.xlsx 2>/dev/null || true

# ── Flag ──────────────────────────────────────────────────────────────────────
mkdir -p /root
cp /tmp/flag.txt /root/flag.txt
chmod 0400 /root/flag.txt

# ── Compile readfile ──────────────────────────────────────────────────────────
gcc /tmp/readfile.c -o /usr/bin/readfile
strip /usr/bin/readfile
chown root:root /usr/bin/readfile
chmod 0755 /usr/bin/readfile
rm /tmp/readfile.c

# ── sudo ──────────────────────────────────────────────────────────────────────
echo "root    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "jake    ALL=(root) NOPASSWD: /usr/bin/passwd -l *, /usr/bin/passwd -u *" >> /etc/sudoers
echo "mitchel ALL=(root) NOPASSWD: /usr/bin/readfile /home/jake/todolist.txt" >> /etc/sudoers

# ── sshd config ───────────────────────────────────────────────────────────────
cp /tmp/sshd_config /etc/ssh/sshd_config
chown root:root /etc/ssh/sshd_config
chmod 0600 /etc/ssh/sshd_config

# ── Wipe all history ──────────────────────────────────────────────────────────
ln -sf /dev/null /root/.ash_history
for user in $(cut -d: -f1 /etc/passwd); do
    home=$(getent passwd "$user" | cut -d: -f6)
    ln -sf /dev/null "$home/.ash_history" 2>/dev/null || true
done

echo "[+] Setup complete"
