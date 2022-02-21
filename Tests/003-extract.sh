#!/bin/sh -e

tar -c "$0" > A.tar

$PKG_CMD new A 1 "file://$PWD/A.tar"
mkdir -p temp
cd temp
$PKG_CMD d A
$PKG_CMD e A

[ -d A ]
find A -name "$(basename "$0")" -exec diff -q {} "$0" \;
