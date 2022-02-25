#!/bin/sh -e

create_factor_packages

$PKG_CMD new __numbers__ meta
echo 12 > __numbers__/depends
$PKG_CMD b __numbers__
$PKG_CMD i __numbers__

$PKG_CMD revdepends 12
[ 0"$($PKG_CMD revdepends 12)" -eq 0 ]
$PKG_CMD r 12

