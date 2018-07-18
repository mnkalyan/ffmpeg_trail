#!/bin/bash -xe
CWD=$(echo $PWD)
rm -fr $CWD/output_bin
./configure --disable-x86asm
make clean
make -j8
top_commit=$(git log --pretty=format:"%H" -- . ":(exclude,icase)output_bin")
echo "Code compiled successfully, copying images to bin folder"
mkdir -p $CWD/output_bin
echo "$top_commit"=$CWD/output_bin/commit_tracker.txt
cp -fr ffmpeg* $CWD/output_bin
touch "$CWD/output_bin/build_done.txt"
