#!/bin/sh -e


set -x
mkdir "$PKGMAN_ROOT/etc"
touch "$PKGMAN_ROOT/etc/C" "$PKGMAN_ROOT/etc/D"
$PKG_CMD new A
echo 'mkdir -p $1/etc' >> A/build
echo 'ln -s A $1/etc/B' >> A/build
echo 'ln -s C $1/etc/D' >> A/build
echo 'ln -s /proc/self $1/self' >> A/build


$PKG_CMD b A
$PKG_CMD i A
$PKG_CMD i A

touch "$PKGMAN_ROOT/etc/A"

$PKG_CMD i A
