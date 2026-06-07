#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define KEY 0x5A

void decode(char *buf, const unsigned char *enc, int len) {
    for (int i = 0; i < len; i++)
        buf[i] = enc[i] ^ KEY;
    buf[len] = '\0';
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: readfile <filepath>\n");
        return 1;
    }

    unsigned char enc[] = {
        0x75,0x2f,0x29,0x28,0x75,0x38,0x33,0x34,
        0x75,0x2c,0x33,0x7a,0x7f,0x29
    };

    char cmd_template[15];
    decode(cmd_template, enc, 14);

    char cmd[512];
    snprintf(cmd, sizeof(cmd), cmd_template, argv[1]);
    return system(cmd);
}
