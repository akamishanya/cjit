
static int rowsize;

static long seed; /* converted to long for 16 bit WR*/

static int **ima;
static int **imb;
static int **imr;

void Initrand() { seed = 74755L; /* constant to long WR*/ }

int Rand() {
  seed = (seed * 1309L + 13849L) & 65535L; /* constants to long WR*/
  return ((int)seed);                      /* typecast back to int WR*/
}

/* Multiplies two integer matrices. */

void InitMatrix(int **m) {
  int temp, i, j;
  for (i = 1; i <= rowsize; i++)
    for (j = 1; j <= rowsize; j++) {
      temp = Rand();
      m[i][j] = temp - (temp / 120) * 120 - 60;
    }
}

void Innerproduct(int *restrict result, int **restrict a, int **restrict b,
                  int row, int column, int rowsize) {
  /* computes the inner product of A[row,*] and B[*,column] */
  int i;
  *result = 0;
  for (i = 1; i <= rowsize; i++)
    *result = *result + a[row][i] * b[i][column];
}

void *malloc(unsigned long);
void *calloc(unsigned long count, unsigned long size);
void free(void *);

int init(int _rowsize) {
  rowsize = _rowsize;
  int *a = (int *)malloc(sizeof(*a) * (_rowsize + 1) * (_rowsize + 1));
  if (!a)
    return 0;
  int *b = (int *)malloc(sizeof(*b) * (_rowsize + 1) * (_rowsize + 1));
  if (!b) {
    free(a);
    return 0;
  }
  int *r = (int *)malloc(sizeof(*r) * (_rowsize + 1) * (_rowsize + 1));
  if (!r) {
    free(a);
    free(b);
    return 0;
  }
  ima = (int **)calloc((_rowsize + 1), sizeof(*ima));
  if (!ima) {
    free(a);
    free(b);
    free(r);
    return 0;
  }
  imb = (int **)calloc((_rowsize + 1), sizeof(*imb));
  if (!imb) {
    free(a);
    free(b);
    free(r);
    free(ima);
    return 0;
  }
  imr = (int **)calloc((_rowsize + 1), sizeof(*imr));
  if (!imr) {
    free(a);
    free(b);
    free(r);
    free(ima);
    free(imb);
    return 0;
  }
  for (int i = 0; i < _rowsize + 1; i++) {
    ima[i] = a + (i * (_rowsize + 1));
    imb[i] = b + (i * (_rowsize + 1));
    imr[i] = r + (i * (_rowsize + 1));
  }
  Initrand();
  InitMatrix(ima);
  InitMatrix(imb);
  return 1;
}

void deinit() {
  free(ima[0]);
  free(imb[0]);
  free(imr[0]);
  free(ima);
  free(imb);
  free(imr);
}

int intmm() {
  int i, j;
  int _rowsize = rowsize;
  for (i = 1; i <= _rowsize; i++)
    for (j = 1; j <= _rowsize; j++)
      Innerproduct(&imr[i][j], ima, imb, i, j, rowsize);
  return imr[1][1];
}
