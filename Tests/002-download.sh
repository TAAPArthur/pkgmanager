#!/bin/sh -e

mkdir temp
export PKGMAN_SOURCE_CACHE_DIR="$PWD/temp"
FILE=$PWD/file
touch "$FILE"
$PKG_CMD new A 1 "file://$FILE"
$PKG_CMD dowload A

[ -d temp/A ]
[ -e "temp/A/$(basename "$FILE")" ]

touch fake_file
$PKG_CMD new B 1 "file://$FILE" "file://$PWD/fake_file"
$PKG_CMD dowload B

[ -d temp/B ]
[ -e "temp/B/$(basename "$FILE")" ]
[ -e "temp/B/fake_file" ]
