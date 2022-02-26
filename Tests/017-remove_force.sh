#!/bin/sh -e

create_factor_packages

$PKG_CMD b 12
$PKG_CMD i 12

$PKG_CMD revdepends 4 | grep 12
PKGMAN_FORCE=1 $PKG_CMD r 4
$PKG_CMD manifest 4 && exit 1
$PKG_CMD manifest 12
