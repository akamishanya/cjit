
static int size;

static long seed;

static int *ima;
static int *imb;
static int *imr;

void Initrand() { seed = 74755L; }

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

unsigned sum_1() {
  int i;
  int _size = size;
  unsigned _sum = 0;
  for (i = 0; i < _size; i++) {
    imr[i] = ima[i] + imb[i];
    _sum += imr[i];
  }
  return _sum;
}
