#!/bin/bash

git submodule update --init --recursive
git pull --recurse-submodules

conan profile detect

VCPKG_DIR=./tools/vcpkg
VCPKG_TRIPLET=x64-windows-static
VCPKG_BOOTSTRAP=bootstrap-vcpkg.sh
USE_PRESET=win-x64-release
# VCPKG_BOOTSTRAP=bootstrap-vcpkg.bat # NEVER RUN .bat here on .sh environment!

COUNT_LINUX=`conan profile show | grep Linux | wc -l`
if [[ "$COUNT_LINUX" -ne 0 ]]; then
    VCPKG_TRIPLET=x64-linux
    # VCPKG_BOOTSTRAP=bootstrap-vcpkg.sh
    USE_PRESET=linux-release
fi

echo "VCPKG_TRIPLET=$VCPKG_TRIPLET"
echo "VCPKG_DIR=$VCPKG_DIR"

mkdir -p tools
git submodule add https://github.com/microsoft/vcpkg $VCPKG_DIR

# DO NOT DO THIS! BECAUSE vcpkg IS SO INSTABLE... IT MAY BREAK EVERY WEEK!
#
# (cd $VCPKG_DIR && git checkout master && git pull)
echo "RUNNING vcpkg boostrap!"
$VCPKG_DIR/$VCPKG_BOOTSTRAP

$VCPKG_DIR/vcpkg --vcpkg-root $VCPKG_DIR search gmp
$VCPKG_DIR/vcpkg --vcpkg-root $VCPKG_DIR search mpir

$VCPKG_DIR/vcpkg --vcpkg-root $VCPKG_DIR integrate install

echo "RUNNING vcpkg install!"
$VCPKG_DIR/vcpkg --vcpkg-root $VCPKG_DIR install --triplet=$VCPKG_TRIPLET

#echo "Applying PATCH"
#cp tools/patch/*.cmake external/cln/cmake/modules/

echo "RUNNING cmake"
mkdir -p build/
# cmake -B build -S . --preset=$USE_PRESET
(cd build && cmake .. --preset=$USE_PRESET) #-DCMAKE_VERBOSE_MAKEFILE=ON)

echo "BUILDING cmake release"
cmake --build build --config Release

echo "CHECK cmake version"
cmake --version

echo "BUILDING example all"
cmake --build build --config Release --target all

echo "EXECUTING my_test"
./build/my_test

echo "EXECUTING pi"
./build/thirdparty/cln/examples/pi

