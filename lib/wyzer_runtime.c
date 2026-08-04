#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void wyzer_ipc_send(const char *target, uint32_t val) {
  char filename[256];
  snprintf(filename, sizeof(filename), "/tmp/wyzer_ipc_%s", target);
  FILE *f = fopen(filename, "w");
  if (f) {
    fprintf(f, "%u\n", val);
    fclose(f);
  } else {
    fprintf(stderr, "Failed to send data to %s\n", target);
    exit(1);
  }
}

uint32_t wyzer_ipc_recv(const char *src) {
  char filename[256];
  snprintf(filename, sizeof(filename), "/tmp/wyzer_ipc_%s", src);
  uint32_t val;
  while (1) {
    FILE *f = fopen(filename, "r");
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

#include <math.h>
#include <time.h>

char *wyzer_std_fs_read_file(const char *path) {
  FILE *f = fopen(path, "rb");
  if (!f)
    return strdup("");
  fseek(f, 0, SEEK_END);
  long len = ftell(f);
  fseek(f, 0, SEEK_SET);
  char *buf = (char *)malloc(len + 1);
  if (!buf) {
    fclose(f);
    return strdup("");
  }
  size_t read_bytes = fread(buf, 1, len, f);
  buf[read_bytes] = '\0';
  fclose(f);
  return buf;
}

bool wyzer_std_fs_write_file(const char *path, const char *content) {
  FILE *f = fopen(path, "wb");
  if (!f)
    return false;
  size_t len = strlen(content);
  size_t written = fwrite(content, 1, len, f);
  fclose(f);
  return written == len;
}

bool wyzer_std_fs_file_exists(const char *path) {
  return access(path, F_OK) == 0;
}

uint64_t wyzer_std_time_now_ms(void) {
  struct timespec ts;
  clock_gettime(CLOCK_REALTIME, &ts);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

void wyzer_std_process_sleep(uint32_t ms) { usleep(ms * 1000); }

void wyzer_std_process_exit(int32_t code) { exit(code); }

char *wyzer_std_io_read_line(void) {
  char buf[1024];
  if (fgets(buf, sizeof(buf), stdin)) {
    size_t len = strlen(buf);
    if (len > 0 && buf[len - 1] == '\n') {
      buf[len - 1] = '\0';
    }
    return strdup(buf);
  }
  return strdup("");
}

int64_t wyzer_std_math_abs(int64_t x) { return x < 0 ? -x : x; }

int64_t wyzer_std_math_min(int64_t a, int64_t b) { return a < b ? a : b; }

int64_t wyzer_std_math_max(int64_t a, int64_t b) { return a > b ? a : b; }

double wyzer_std_math_sin(double x) { return sin(x); }
double wyzer_std_math_cos(double x) { return cos(x); }
double wyzer_std_math_tan(double x) { return tan(x); }
double wyzer_std_math_sqrt(double x) { return sqrt(x); }
double wyzer_std_math_pow(double base, double exp) { return pow(base, exp); }
double wyzer_std_math_log(double x) { return log(x); }

int64_t wyzer_std_math_clamp(int64_t val, int64_t min_v, int64_t max_v) {
  if (val < min_v)
    return min_v;
  if (val > max_v)
    return max_v;
  return val;
}
