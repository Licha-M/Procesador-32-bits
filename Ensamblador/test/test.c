int argumentos(int a, int b, int c, int d, int e, int f, int g, int h) {
  a = a + 1;
  b = b + 2;
  c = c + 3;
  d = d + 4;
  e = e + 5;
  f = f + 6;
  g = g + 7;
  return a + b + c + d + e + f + g + h;
}

int fibonacci(int n) {
  if (n == 0)
    return 0;
  if (n == 1)
    return 1;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

int test_complex_switch(int val) {
  switch (val) {
  case 1:
    return 10;
  case 2:
    return 20;
  case 3:
    return 30;
  case 100:
    return 400;
  case 500:
    return 5000;
  default:
    return -1;
  }
}

int test_nested_loops(int limite) {
  int acumulador = 0;
  int i = 0;
  while (i < limite) {
    for (int j = 0; j < 5; j++) {
      acumulador += (i * j);
    }
    i++;
  }
  return acumulador;
}

int test_multidim_array(int fila, int col) {
  int matriz[3][4] = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10, 11, 12}};
  if (fila >= 0 && fila < 3 && col >= 0 && col < 4) {
    return matriz[fila][col];
  }
  return 0;
}

struct BigData {
  int a, b, c, d, e;
};

int procesar_struct(struct BigData data) {
  return data.a + data.b + data.c + data.d + data.e;
}

int test_struct_by_value() {
  struct BigData paquete = {10, 20, 30, 40, 50};
  return procesar_struct(paquete);
}

int test_pointer_arithmetic(int *arreglo, int tamaño) {
  int suma = 0;
  int *ptr = arreglo;
  for (int i = 0; i < tamaño; i++) {
    suma += *ptr;
    ptr++;
  }
  return suma;
}

int main() { return 0x12345678; }