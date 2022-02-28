#!/bin/sh -e

FILE=$PWD/file
touch "$FILE"

$PKG_CMD new A 1 "file://$FILE"
mkdir -p temp
cd temp
$PKG_CMD d A
$PKG_CMD e A

[ -d A ]
[ -e A/file ]
diff -q A/file "$FILE"
