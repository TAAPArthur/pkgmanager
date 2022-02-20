#!/bin/sh -e

$PKG_CMD new A
echo 'cd $1; touch a b c' >> A/build

$PKG_CMD b A
$PKG_CMD i A

$PKG_CMD r A

for file in a b c; do
    [ ! -e "$PKGMAN_ROOT/$file" ]
done

if $PKG_CMD l A ; then
    exit 2
fi
