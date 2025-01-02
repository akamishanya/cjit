extern double sin(double);
extern double cos(double);

double test(int *arr, unsigned n) {
  double res = 0;
  for (int i = 0; i < n; i++) {
    double partial_res = sin(arr[i]) * cos(arr[i]);
    if (arr[i] < 0)
      res += partial_res;
    res += arr[i];
  }
  return res;
}
