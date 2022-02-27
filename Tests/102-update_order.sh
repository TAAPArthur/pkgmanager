#!/bin/sh -e

$PKG_CMD new A
$PKG_CMD new B
$PKG_CMD new C

echo "B" | tee A/depends C/depends
echo 'set -xe; [ "$($PKG_CMD list B | cut -f2)" = "$2 $3" ]' | tee -a A/build C/build

$PKG_CMD b A B C
$PKG_CMD i A B C

echo HERE
set -x
for v in "1 2" "2 1" "3 3"; do
    echo "$v" | tee A/version B/version C/version
    $PKG_CMD update
done
