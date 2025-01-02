
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
  InitArray(ima, size);
  InitArray(imb, size);
  return 1;
}

void deinit() {
  free(ima);
  free(imb);
  free(imr);
}

void abort();

int read_arr(int *arr, int arr_size, int i) {
  if (!arr || i < 0 || i >= arr_size)
    abort();
  return arr[i];
}

void write_arr(int *arr, int arr_size, int i, int val) {
  if (!arr || i < 0 || i >= arr_size)
    abort();
  arr[i] = val;
}

unsigned sum_4() {
  int _size = size;
  unsigned _sum = 0;

  for (int i = 0; i < _size; i++) {
    int a = read_arr(ima, _size, i);
    int b = read_arr(imb, _size, i);
    int sum = a + b;
    write_arr(imr, _size, i, sum);
    _sum += read_arr(imr, _size, i);
  }

  return _sum;
}
