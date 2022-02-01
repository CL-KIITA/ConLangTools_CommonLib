/**
Internal Library contains math functions.
*/


import "dart:math";

export "dart:math";

/**
formal Logarithm: log
*/
double flog(num x, [num? ladix]) {
  if (ladix == null) {
    return log(x);
  } else {
    return log(x) / log(ladix);
  }
}

/**
Common Logarithm: lg
*/
double clog(num x) {
  return flog(x, 10);
}

/**
Natural Logarithm: ln
*/
double clog(num x) {
  return flog(x, e);
}

/**
Binary Logarithm: lb
*/
double clog(num x) {
  return flog(x, 2);
}