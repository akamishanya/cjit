
static int size;

static long seed;

static int *ima;
static int *imb;
static int *imr;

void Initrand() { seed = 8232L; }

int Rand() {
  seed = (seed * 1309L + 13849L) & 65535L;
  return ((int)seed);
}

void InitArray(int *a) {
  int temp, i, j;
  for (i = 0; i < size; i++) {
    temp = Rand();
    a[i] = temp - (temp / 120) * 120 - 60;
  }
}

void *malloc(unsigned long);
void *calloc(unsigned long count, unsigned long size);
void free(void *);

int init(int _size) {
  size = _size;
  ima = (int *)calloc((_size), sizeof(*ima));
  if (!ima) {
    return 0;
  }
  imb = (int *)calloc((_size), sizeof(*imb));
  if (!imb) {
    free(ima);
    return 0;
  }
  imr = (int *)calloc((_size), sizeof(*imr));
  if (!imr) {
    free(ima);
    free(imb);
    return 0;
  }
  Initrand();
  InitArray(ima);
  InitArray(imb);
  return 1;
}

void deinit() {
  free(ima);
  free(imb);
  free(imr);
}

void abort();

unsigned sum_2() {
  int i, j;
  int _size = size;
  unsigned _sum = 0;

#define READ_ARR(arr, arr_size, idx, target)                                   \
  if (!arr || i < 0 || i >= arr_size)                                           \
    abort();                                                                   \
  target = arr[idx]

#define WRITE_ARR(arr, arr_size, idx, val)                                     \
  if (!arr || i < 0 || i >= arr_size)                                           \
    abort();                                                                   \
  arr[idx] = val

  for (i = 0; i < _size; i++) {
    int a, b;
    READ_ARR(ima, _size, i, a);
    READ_ARR(imb, _size, i, b);
    int sum = a + b;
    WRITE_ARR(imr, _size, i, sum);
    int add;
    READ_ARR(imr, _size, i, add);
    _sum += add;
  }

  return _sum;
}
