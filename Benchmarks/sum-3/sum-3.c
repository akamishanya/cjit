
static int size1;
static int size2;
static int size3;

static long seed;

static int *ima;
static int *imb;
static int *imr;

void Initrand() { seed = 8232L; }

int Rand() {
  seed = (seed * 1309L + 13849L) & 65535L;
  return ((int)seed);
}

void InitArray(int *a, int size) {
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
  size1 = _size;
  size2 = _size;
  size3 = _size;
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
  InitArray(ima, size1);
  InitArray(imb, size2);
  return 1;
}

void deinit() {
  free(ima);
  free(imb);
  free(imr);
}

void abort();

unsigned sum_3() {
  int _size1 = size1;
  int _size2 = size2;
  int _size3 = size3;
  unsigned _sum = 0;

#define READ_ARR(arr, arr_size, idx, target)                                   \
  if (!arr || i < 0 || i >= arr_size)                                          \
    abort();                                                                   \
  target = arr[idx]

#define WRITE_ARR(arr, arr_size, idx, val)                                     \
  if (!arr || i < 0 || i >= arr_size)                                          \
    abort();                                                                   \
  arr[idx] = val

  for (int i = 0; i < _size1; i++) {
    int a, b;
    READ_ARR(ima, _size1, i, a);
    READ_ARR(imb, _size2, i, b);
    int sum = a + b;
    WRITE_ARR(imr, _size3, i, sum);
    int add;
    READ_ARR(imr, _size3, i, add);
    _sum += add;
  }

  return _sum;
}
