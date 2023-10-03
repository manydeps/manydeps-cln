// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 - manydeps - https://github.com/manydeps
//
// License is a combination of:
// - CLN (GPL-2.0-or-later)
// - GMP (GPL-2.0-or-later OR LGPL-3.0-or-later)

#include <iostream>
//
#include <catch2/catch_all.hpp>
//
#include <gmp.h>    // NOLINT
#include <gmpxx.h>  // NOLINT
//
#include <cln/string.h>
//

namespace cln {
extern cl_heap_string* cl_make_heap_string(const char* ptr);
}

TEST_CASE("Teste1-X") {
  int x = 10;
  REQUIRE(x == 10);
}

TEST_CASE("Teste2-X") {
  mpz_class a, b, c;
  a = 1234;
  b = "-5678";
  c = a + b;
  bool r = (c == -4444);
  REQUIRE(r);
}
