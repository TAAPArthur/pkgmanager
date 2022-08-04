#!/bin/sh -e

mkdir temp
cd temp
$PKG_CMD new A 1 files/file
mkdir A/files
touch A/files/file
PKG_DESTDIR=A_extract $PKG_CMD extract A/
[ -d A_extract ]
[ -e A_extract/file ]
$PKG_CMD b A/
$PKG_CMD i A/
$PKG_CMD list A/ | grep A
$PKG_CMD r A/
$PKG_CMD list | grep A && exit 1
exit 0
