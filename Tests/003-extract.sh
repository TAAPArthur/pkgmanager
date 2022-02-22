#!/bin/sh -e

FILE=$PWD/file
touch "$FILE"
tar -c "$FILE" > A.tar

$PKG_CMD new A 1 "file://$PWD/A.tar"
mkdir -p temp
cd temp
$PKG_CMD d A
$PKG_CMD e A

[ -d A ]
find A -name "$(basename "$FILE")" -exec diff -q {} "$FILE" \;
