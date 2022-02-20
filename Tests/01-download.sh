#!/bin/sh -e

mkdir temp
export PKGMAN_SOURCE_CACHE_DIR="$PWD/temp"

$PKG_CMD new A 1 "file://$0"
$PKG_CMD d A

[ -d temp/A ]
[ -e "temp/A/$(basename "$0")" ]

touch fake_file
$PKG_CMD new B 1 "file://$0" "file://$PWD/fake_file"
$PKG_CMD d B

[ -d temp/B ]
[ -e "temp/B/$(basename "$0")" ]
[ -e "temp/B/fake_file" ]
