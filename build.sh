#!/bin/bash -xe
CWD=$(echo $PWD)
rm -fr $CWD/output_bin
./configure --disable-x86asm
make clean
make -j8
top_commit=$(git log --pretty=format:"%H" -- . ":(exclude,icase)output_bin" | head -1)
echo "Code compiled successfully, copying images to bin folder"
mkdir -p $CWD/output_bin
echo "$top_commit" > $CWD/commit_tracker.txt
cp -fr ffmpeg* $CWD/output_bin

echo "Update output_bin in github for testing"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=7200'
git add ./output_bin
git commit -m "Compilation passed successfully with $top_commit as ToT" -s --no-edit
git push origin master
touch "$CWD/output_bin/build_done.txt"
echo "All done"
