#!/bin/sh -e

create_factor_packages

$PKG_CMD b 12
$PKG_CMD i 12

$PKG_CMD revdepends 4 | grep 12
$PKG_CMD r 4 && exit 1
$PKG_CMD list 4

$PKG_CMD r 4 2 12 6
! $PKG_CMD list 4 || exit 1
! $PKG_CMD list 2 || exit 1
! $PKG_CMD list 12 || exit 1
$PKG_CMD list 1
$PKG_CMD list 3
