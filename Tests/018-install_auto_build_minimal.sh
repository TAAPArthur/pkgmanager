#!/bin/sh -e

create_factor_packages

$PKG_CMD i 1

$PKG_CMD list 0 1
$PKG_CMD r 0
$PKG_CMD r 1
# There's no need to build the make dependency 0 since 1 is already built
$PKG_CMD i 1
$PKG_CMD list | grep -q 0 && exit 1
$PKG_CMD list | grep 1

