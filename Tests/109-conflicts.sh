#!/bin/sh

$PKG_CMD new A
$PKG_CMD new B
$PKG_CMD new C

echo 'touch "$1/file"' | tee A/build B/build C/build >/dev/null

$PKG_CMD b A B C

$PKG_CMD i B A C

$PKG_CMD manifest A C | grep "^/file" && exit 1
$PKG_CMD manifest B | grep "^/file"

[ "$($PKG_CMD owns "/file")" = B ]

$PKG_CMD a | grep A
$PKG_CMD a | grep B && exit 1
$PKG_CMD a | grep C
$PKG_CMD a | grep A | $PKG_CMD a -

$PKG_CMD manifest B C | grep "^/file" && exit 1
$PKG_CMD manifest A | grep "^/file"
$PKG_CMD a | grep A && exit 1
[ "$($PKG_CMD owns "/file")" = A ]
