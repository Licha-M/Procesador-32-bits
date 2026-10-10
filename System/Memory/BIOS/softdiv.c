// softdiv.c — compilar e incluir en el llvm-link junto al resto de fuentes
__attribute__((always_inline)) unsigned int __udivsi3(unsigned int n,
                                                      unsigned int d) {
  if (d == 0)
    return 0; // tu spec: 0/0 (y cualquier /0) da 0
  unsigned int q = 0, r = 0;
  for (int i = 31; i >= 0; i--) {
    r = (r << 1) | ((n >> i) & 1);
    if (r >= d) {
      r -= d;
      q |= (1u << i);
    }
  }
  return q;
}

__attribute__((always_inline)) unsigned int __umodsi3(unsigned int n,
                                                      unsigned int d) {
  if (d == 0)
    return 0;
  unsigned int r = 0;
  for (int i = 31; i >= 0; i--) {
    r = (r << 1) | ((n >> i) & 1);
    if (r >= d)
      r -= d;
  }
  return r;
}