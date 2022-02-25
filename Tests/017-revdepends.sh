#!/bin/sh -e

create_factor_packages

$PKG_CMD b $(seq 1 12)
$PKG_CMD i $(seq 1 12)

$PKG_CMD revdepends 4
$PKG_CMD revdepends 4 | grep -x "8\s"
$PKG_CMD revdepends 4 | grep -x "12\s"
$PKG_CMD revdepends 4 | grep -x "2\s" && exit 1
$PKG_CMD revdepends 4 | grep -x "1\s" && exit 1
for i in $(seq 7 12); do
    [ -z "$($PKG_CMD revdepends "$i")" ]
done

for i in $(seq 0 6); do
    [ -n "$($PKG_CMD revdepends "$i")" ]
done
