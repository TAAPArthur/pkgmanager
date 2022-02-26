#!/bin/sh -e


$PKG_CMD new A 1 "files/file"
mkdir A/files
touch A/files/file
echo "[ -r file ]" >> A/build
echo 'mv file $1/' >> A/build

$PKG_CMD b A
$PKG_CMD i A

[ -r "$PKGMAN_ROOT/file" ]
