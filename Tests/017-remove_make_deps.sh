#!/bin/sh -e

create_factor_packages

$PKG_CMD b 12
$PKG_CMD i 12

[ 0"$($PKG_CMD revdepends 0 | grep -v make)" -eq 0 ]
$PKG_CMD r 0
