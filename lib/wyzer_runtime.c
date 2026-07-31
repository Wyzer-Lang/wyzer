#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>
#include <stdbool.h>

void wyzer_ipc_send(const char* target, uint32_t val) {
    char filename[256];
    snprintf(filename, sizeof(filename), "/tmp/wyzer_ipc_%s", target);
    FILE* f = fopen(filename, "w");
    if (f) {
        fprintf(f, "%u\n", val);
        fclose(f);
    } else {
        fprintf(stderr, "Failed to send data to %s\n", target);
        exit(1);
    }
}

uint32_t wyzer_ipc_recv(const char* src) {
    char filename[256];
    snprintf(filename, sizeof(filename), "/tmp/wyzer_ipc_%s", src);
    uint32_t val;
    while (1) {
        FILE* f = fopen(filename, "r");
        if (f) {
            if (fscanf(f, "%u", &val) == 1) {
                fclose(f);
                remove(filename);
                return val;
            }
            fclose(f);
        }
        usleep(10000); // 10ms poll
    }
}
