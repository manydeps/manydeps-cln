load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

package(
    default_visibility = ["//visibility:public"],
)

# thirdparty vcpkg-installed GMP library
cc_library(
    name = "lib",
    srcs = glob(
        ["src/**/*.c",
        "src/**/*.cc"],
        exclude = [
            "src/base/digitseq/cl_asm_hppa_.cc",
            "src/base/digitseq/cl_asm_i386_.cc",
            "src/base/digitseq/cl_asm_arm_.cc",
            "src/base/digitseq/cl_asm_mips_.cc",
            "src/base/digitseq/cl_asm_mipsel_.cc",
            "src/base/digitseq/cl_asm_m68k_.cc",
            "src/base/digitseq/cl_asm_sparc64_.cc",
            "src/base/digitseq/cl_asm_sparc_.cc",
            "src/polynomial/elem/cl_asm_sparc_GF2.cc",
        ],
    ),
    hdrs = glob([
        "include/**/*.h",
        "src/**/*.h",
        "autoconf/**/*.h",
        "src/float/sfloat/**/*.cc",
        "src/float/ffloat/**/*.cc",
        "src/float/dfloat/**/*.cc",
        "src/float/lfloat/**/*.cc",
        "src/rational/misc/**/*.cc",
        "src/integer/misc/**/*.cc",
        "src/integer/conv/**/*.cc",
        "src/complex/algebraic/cl_C_abs_aux.cc",
        "src/real/conv/cl_F_from_R_def.cc",
        "src/integer/misc/cl_I_signum.cc",
        "src/rational/misc/cl_RA_signum.cc",
        "src/real/algebraic/cl_RA_sqrt.cc",
    ]),
    includes = ["include/", "src/", "autoconf/",],
    deps = ["@gmp//:lib"],
    visibility = ["//visibility:public"],
    linkstatic = 1
)

# bazel run @cln//:cln_example_fibonacci 10
cc_binary(
    name = "cln_example_fibonacci",
    srcs = ["examples/fibonacci.cc"],
    deps = [":lib"],
    visibility = ["//visibility:public"],
)
