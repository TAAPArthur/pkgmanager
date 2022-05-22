#!/bin/sh -e

$PKG_CMD new A

{
echo 'touch file'
echo 'mv * $1/'
} > A/build
echo "non-existant-file" > A/sources

mkdir temp
cd temp
touch test_file
PKGMAN_FAKE_BUILD=1 $PKG_CMD b A
$PKG_CMD i A

[ -e "$PKGMAN_ROOT/file" ]
[ -e "$PKGMAN_ROOT/test_file" ]

