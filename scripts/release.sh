#!/usr/bin/env bash

PLATFORM="linux"
ARCH="amd64"
VERSION="3.0.0"
RELEASE_NAME="cudd_${VERSION}_${PLATFORM}-${ARCH}"
prefix="/usr/local"
includedir="${prefix}/include/"

OUTPUT_DIR="${RELEASE_NAME}"
OUTPUT_TAR="${RELEASE_NAME}.tar.gz"

./configure --includedir "${includedir}" --enable-silent-rules --enable-obj --enable-dddmp --enable-shared --prefix="${prefix}"
make -j4

rm -rf "${OUTPUT_DIR}"
mkdir "${OUTPUT_DIR}"
cp README "${OUTPUT_DIR}"

mkdir "${OUTPUT_DIR}"/lib
cp -P cudd/.libs/libcudd.lai "${OUTPUT_DIR}"/lib/libcudd.la
cp -P cudd/.libs/libcudd.a "${OUTPUT_DIR}"/lib
cp -P cudd/libcudd.la "${OUTPUT_DIR}"/lib
# works only if configured with --enabled-shared
cp -P cudd/.libs/libcudd.so "${OUTPUT_DIR}"/lib/ || true
cp -P cudd/.libs/libcudd-3* "${OUTPUT_DIR}"/lib/ || true

strip --strip-debug "${OUTPUT_DIR}"/lib/libcudd.a

mkdir "${OUTPUT_DIR}"/include
cp -P cudd/cudd.h "${OUTPUT_DIR}"/include/
cp -P cplusplus/cuddObj.hh "${OUTPUT_DIR}"/include/
cp -P dddmp/dddmp.h "${OUTPUT_DIR}"/include/

tar -c "${OUTPUT_DIR}" -f "${OUTPUT_TAR}"
rm -r "${OUTPUT_DIR}"

echo "Output in ${OUTPUT_TAR}"
