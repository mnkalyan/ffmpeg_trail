#!/bin/bash -xe
CWD=$(echo $PWD)
rm -fr $CWD/bin
./configure --disable-x86asm
make clean
make -j8

echo "Code compiled successfully, copying images to bin folder"
mkdir -p $CWD/bin
cp -fr ffmpeg* $CWD/bin
touch "$CWD/bin/build_done.txt"

