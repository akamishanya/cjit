
/*
    index = 1 .. rowsize;
    intmatrix = array [index,index] of integer;
*/

static long seed; /* converted to long for 16 bit WR*/

static int rowsize;
static float **rma;
static float **rmb;
static float **rmr;

static void Initrand() { seed = 74755L; /* constant to long WR*/ }

static int Rand() {
  seed = (seed * 1309L + 13849L) & 65535L; /* constants to long WR*/
  return ((int)seed);                      /* typecast back to int WR*/
}

/* Multiplies two real matrices. */

static void rInitmatrix(float **m) {
  int temp, i, j;
  for (i = 1; i <= rowsize; i++)
    for (j = 1; j <= rowsize; j++) {
      temp = Rand();
      m[i][j] = (float)(temp - (temp / 120) * 120 - 60) / 3;
    }
}

static void rInnerproduct(float *result, float **a, float **b, int row,
                          int column) {
  /* computes the inner product of A[row,*] and B[*,column] */
  int i;
  *result = 0.0f;
  for (i = 1; i <= rowsize; i++)
    *result = *result + a[row][i] * b[i][column];
}

void *malloc(unsigned long);
void free(void *);

int init(int _rowsize) {
  rowsize = _rowsize;
  float *a = (float *)malloc(sizeof(*a) * (_rowsize + 1) * (_rowsize + 1));
  if (!a)
    return 0;
  float *b = (float *)malloc(sizeof(*b) * (_rowsize + 1) * (_rowsize + 1));
  if (!b) {
    free(a);
    return 0;
  }
  float *r = (float *)malloc(sizeof(*r) * (_rowsize + 1) * (_rowsize + 1));
  if (!r) {
    free(a);
    free(b);
    return 0;
  }
  rma = (float **)malloc(sizeof(*rma) * (_rowsize + 1));
  if (!rma) {
    free(a);
    free(b);
    free(r);
    return 0;
  }
  rmb = (float **)malloc(sizeof(*rmb) * (_rowsize + 1));
  if (!rmb) {
    free(a);
    free(b);
    free(r);
    free(rma);
    return 0;
  }
  rmr = (float **)malloc(sizeof(*rmr) * (_rowsize + 1));
  if (!rmr) {
    free(a);
    free(b);
    free(r);
    free(rma);
    free(rmb);
    return 0;
  }
  for (int i = 0; i < _rowsize + 1; i++) {
    rma[i] = a + (i * (_rowsize + 1));
    rmb[i] = b + (i * (_rowsize + 1));
    rmr[i] = r + (i * (_rowsize + 1));
  }
  Initrand();
  rInitmatrix(rma);
  rInitmatrix(rmb);
  return 1;
}

void deinit() {
  free(rma[0]);
  free(rmb[0]);
  free(rmr[0]);
  free(rma);
  free(rmb);
  free(rmr);
}

double floatmm() {
  int i, j;
  for (i = 1; i <= rowsize; i++)
    for (j = 1; j <= rowsize; j++)
      rInnerproduct(&rmr[i][j], rma, rmb, i, j);
  return rmr[1][1];
}
