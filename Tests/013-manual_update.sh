#!/bin/sh -e

$PKG_CMD new A
echo 'touch "$1/a"'  >> A/build
$PKG_CMD b A
$PKG_CMD i A
[ -e "$PKGMAN_ROOT/a" ]
rm "$PKGMAN_ROOT/a"

set -xe
$PKG_CMD i A
[ -e "$PKGMAN_ROOT/a" ]

echo "1 2" > A/version
$PKG_CMD b A
$PKG_CMD i A
$PKG_CMD list A | grep "1 2"


