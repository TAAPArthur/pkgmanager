#!/bin/sh -e

$PKG_CMD new A
echo 'cd $1; touch a b c' >> A/build

$PKG_CMD b A

for file in a b c; do
    [ ! -e "$file" ]
done

$PKG_CMD i A

for file in a b c; do
    [ -e "$PKGMAN_ROOT/$file" ]
done

$PKG_CMD list A
