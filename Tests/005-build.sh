#!/bin/sh -ex

$PKG_CMD new A
echo 'cd $1; touch a b c' >> A/build
$PKG_CMD b A
$PKG_CMD export A

tar -t -f ./*.tar* > output.txt
cat output.txt
for file in a b c; do
    grep -q -x "./$file" output.txt
done

grep -q "manifest" output.txt
grep -q -v "tmp" output.txt
