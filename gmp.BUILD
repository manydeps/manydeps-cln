load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

package(
    default_visibility = ["//visibility:public"],
)

# DOCUMENTATION ON SELECT:
# https://bazel.build/reference/be/functions?hl=pt-br#select

# thirdparty vcpkg-installed GMP library
cc_library(
    name = "lib",
    #srcs = glob(
    #    ["vcpkg_installed/x64-linux/lib/**/*.a"],
    #    ["vcpkg_installed/x64-linux/lib/**/*.lib"]
    #),
    srcs = select({
        "@bazel_tools//src/conditions:windows": glob([".libs/**/gmp.lib", ".libs/**/gmp.dll"]),
        "@bazel_tools//src/conditions:darwin": glob(["gmp_x64-osx/lib/**/*.a"]),
        "//conditions:default": glob([".libs/**/libgmp.a", ".libs/**/libgmp.so"]),
    }),
    #hdrs = glob(["vcpkg_installed/x64-linux/include/**/*.h"]),
    hdrs = select({
        "@bazel_tools//src/conditions:windows": glob(["gmp.h", "gmpxx.h"]),
        "@bazel_tools//src/conditions:darwin": glob(["gmp_x64-osx/include/**/*.h"]),
        "//conditions:default": glob(["gmp.h", "gmpxx.h"]),
    }),
    #includes = ["vcpkg_installed/x64-linux/include/"],
    includes = select({
        "@bazel_tools//src/conditions:windows": [""],
        "@bazel_tools//src/conditions:darwin": ["gmp_x64-osx/include/"],
        "//conditions:default": [""],
    }),
    visibility = ["//visibility:public"],
    #linkstatic = 1
)
