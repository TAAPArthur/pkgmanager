#!/bin/sh -e

create_factor_packages

mkdir temp
cd temp

$PKG_CMD new 24
$PKG_CMD new 16
echo 12 > 24/depends
echo 8 > 16/depends

$PKG_CMD b 24 16/
$PKG_CMD i 24 16/

$PKG_CMD list | grep -q 24
$PKG_CMD list | grep -q 16

$PKG_CMD tree 24  | grep 4
$PKG_CMD tree 16/ | grep 4

$PKG_CMD r 24 16/
$PKG_CMD list | grep 24 && exit 1
$PKG_CMD list | grep 16 && exit 1
exit 0
