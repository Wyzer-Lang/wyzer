
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define wyzer_rc_inc(ptr) /* no-op for now */
#define wyzer_rc_dec(ptr) /* no-op for now */

void wyzer_ipc_send(const char* target, uint32_t val) {
    char filename[256];
    sprintf(filename, "/tmp/wyzer_ipc_%s", target);
    FILE* f = fopen(filename, "w");
    if (f) {
        fprintf(f, "%u\n", val);
        fclose(f);
    }
}

uint32_t wyzer_ipc_recv(const char* src) {
    char filename[256];
    sprintf(filename, "/tmp/wyzer_ipc_%s", src);
    uint32_t val = 0;
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
    }
    return val;
}


void wyzer_main() {
  auto size_u32 = 4;
  auto size_u64 = 8;
  auto my_var = 42;
  auto type_name = "i32@Poly";
  printf("%s\n", "Type of my_var:");
  printf("%s\n", type_name);
  /* drop type_name */;
  /* drop size_u64 */;
  /* drop size_u32 */;
  /* drop my_var */;
}


int main() {
    wyzer_main();
    return 0;
}

