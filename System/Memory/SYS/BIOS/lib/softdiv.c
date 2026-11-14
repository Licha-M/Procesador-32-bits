// Calcula la division entera sin signo (n / d) por software mediante desplazamiento y resta bit a bit.
__attribute__((always_inline)) unsigned int __udivsi3(unsigned int n, unsigned int d) {
  if (d == 0) return 0;
  unsigned int q = 0, r = 0;
  for (int i = 31; i >= 0; i--) {
    // Desplaza el residuo a la izquierda e inserta el bit i-esimo del dividendo.
    r = (r << 1) | ((n >> i) & 1);
    // Si el residuo acumulado es mayor o igual al divisor, lo resta y activa el bit en el cociente.
    if (r >= d) {
      r -= d;
      q |= (1u << i);
    }
  }
  return q;
}

// Calcula el resto de la division sin signo (n % d) por software mediante desplazamiento y resta bit a bit.
__attribute__((always_inline)) unsigned int __umodsi3(unsigned int n, unsigned int d) {
  if (d == 0) return 0;
  unsigned int r = 0;
  for (int i = 31; i >= 0; i--) {
    // Desplaza el residuo a la izquierda e inserta el bit i-esimo del dividendo.
    r = (r << 1) | ((n >> i) & 1);
    // Si el residuo acumulado es mayor o igual al divisor, resta el divisor manteniendo el resto.
    if (r >= d) r -= d;
  }
  return r;
}
