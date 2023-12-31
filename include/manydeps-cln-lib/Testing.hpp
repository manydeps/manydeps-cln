// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 - manydeps - https://github.com/manydeps
//
// License is a combination of:
// - CLN (GPL-2.0-or-later)
// - GMP (GPL-2.0-or-later OR LGPL-3.0-or-later)

#pragma once

// C
#include <stdio.h>
// C++
#include <iostream>
// thirdparty (testing)
#include <cln/integer.h>     // NOLINT
#include <cln/integer_io.h>  // NOLINT
#include <cln/io.h>          // NOLINT
#include <cln/number.h>      // NOLINT

using namespace cln;  // NOLINT

// FROM SAMPLE fibonacci!

struct twofibs {
  cl_I u;  // F_n
  cl_I v;  // F_(n+1)
  // Constructor.
  twofibs(const cl_I& uu, const cl_I& vv) : u(uu), v(vv) {}
};

// Returns F_n and F_(n+1). Assume n>=0.
static const twofibs fibonacci2(int n) {
  if (n == 0) return twofibs(0, 1);
  int m = n / 2;  // floor(n/2)
  twofibs Fm = fibonacci2(m);
  // Since a squaring is cheaper than a multiplication, better use
  // three squarings instead of one multiplication and two squarings.
  cl_I u2 = square(Fm.u);
  cl_I v2 = square(Fm.v);
  if (n == 2 * m) {
    // n = 2*m
    cl_I uv2 = square(Fm.v - Fm.u);
    return twofibs(v2 - uv2, u2 + v2);
  } else {
    // n = 2*m+1
    cl_I uv2 = square(Fm.u + Fm.v);
    return twofibs(u2 + v2, uv2 - u2);
  }
}

// Returns just F_n. Assume n>=0.
const cl_I fibonacci(int n) {
  if (n == 0) return 0;
  int m = n / 2;  // floor(n/2)
  twofibs Fm = fibonacci2(m);
  if (n == 2 * m) {
    // n = 2*m
    // Here we don't use the squaring formula because
    // one multiplication is cheaper than two squarings.
    cl_I& u = Fm.u;
    cl_I& v = Fm.v;
    return u * ((v << 1) - u);
  } else {
    // n = 2*m+1
    cl_I u2 = square(Fm.u);
    cl_I v2 = square(Fm.v);
    return u2 + v2;
  }
}

#include <cln/string.h>

namespace cln {
extern cl_heap_string* cl_make_heap_string(const char* ptr);
}

int basic_testing() {
  //
  int n = 6;
  cl_I r = fibonacci(n);  // 5+3=8
  std::cout << "fib(" << n << ") = " << r << std::endl;
  // testing 'cl_make_heap_string' from library
  std::string str("123");
  cln::cl_heap_string* out = cln::cl_make_heap_string(str.c_str());
  std::cout << out << std::endl;
  cl_free_heap_object(out);
  //
  return 0;
}
