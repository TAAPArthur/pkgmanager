#!/bin/sh -e

mkdir temp
cd temp
$PKG_CMD new A 1 files/file
mkdir A/files
touch A/files/file
cd A
[ ! -d A ]
$PKG_CMD extract
[ -d A ]
[ -e A/file ]
$PKG_CMD b
$PKG_CMD i
$PKG_CMD list | grep A
set -x
$PKG_CMD r
$PKG_CMD list | grep A && exit 1
exit 0
