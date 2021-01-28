#!/usr/bin/env bash

prefix="/usr/local"
includedir="${prefix}/include/cudd"

./configure --includedir "${includedir}" --enable-silent-rules --enable-obj --enable-dddmp --enable-shared\n
make -j && sudo make install-strip

rm -rf release
mkdir release
cp README release/

mkdir release/lib
cp -P cudd/.libs/libcudd.lai release/lib/libcudd.la
cp -P cudd/.libs/libcudd.a release/lib 
chmod 664 release/lib/libcudd.a
strip --strip-debug release/lib/libcudd.a


mkdir release/include
mkdir release/include/cudd
cp cudd/cudd.h release/include/cudd
cp dddmp/dddmp.h release/include/cudd
cp cplusplus/cuddObj.hh release/include/cudd

zip -r release.zip release

