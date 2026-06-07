# Stage 1 — Users, Groups, and Sudo

## Groups created
finance, hr, marketing, sales, executive, guest, it, itAdmin

## User allocations
- jake → it
- mitchel → itAdmin
- All others → randomised across finance/hr/marketing/sales/executive/guest

## Sudo rules
- jake: `sudo /usr/bin/passwd -l *` and `sudo /usr/bin/passwd -u *`
- mitchel: `sudo /usr/bin/readfile /home/jake/todolist.txt`
- root: full sudo

## Account state at startup
- mitchel is locked (jake must unlock as part of the challenge)
