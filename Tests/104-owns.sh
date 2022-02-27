#!/bin/sh -e

$PKG_CMD list
$PKG_CMD new A
$PKG_CMD new B
echo 'touch $1/A_file' >> A/build
echo 'touch $1/B_file' >> B/build
touch "$PKGMAN_ROOT/not_A_file"
touch "$PKGMAN_ROOT/not_B_file"

$PKG_CMD b A B
$PKG_CMD i A B

[ "$($PKG_CMD owns "/A_file")" = A ]
[ "$($PKG_CMD owns "/B_file")" = B ]
[ -z "$($PKG_CMD owns "/not_a_file")" ]
$PKG_CMD owns "/not_A_file" && exit 1
$PKG_CMD owns "/not_B_file" && exit 1
$PKG_CMD owns "/not_a_file" && exit 1
exit 0
