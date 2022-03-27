#!/bin/sh -e

export PKGMAN_FORCE=1
$PKG_CMD update

$PKG_CMD new A
$PKG_CMD b A
$PKG_CMD i A

echo " exit 1" >> A/build
$PKG_CMD update

echo "" > A/build
echo "1 2" > A/version

$PKG_CMD update

$PKG_CMD list A
$PKG_CMD list A | grep "1 2"


$PKG_CMD new B
$PKG_CMD b B
$PKG_CMD i B

echo "1 3" > A/version
echo "2 1" > B/version

$PKG_CMD update
$PKG_CMD list A | grep "1 3"
$PKG_CMD list B | grep "2 1"
