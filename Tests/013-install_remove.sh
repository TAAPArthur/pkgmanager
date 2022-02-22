#!/bin/sh -e

$PKG_CMD new A
echo 'cd $1; touch a b c' >> A/build

$PKG_CMD b A
# We should not need to build A again
echo " exit 1" >> A/build

for _ in 1 2 3; do
    $PKG_CMD i A
    $PKG_CMD list A | grep "A"
    $PKG_CMD r A
    if $PKG_CMD l A ; then
        exit 1
    fi
done
