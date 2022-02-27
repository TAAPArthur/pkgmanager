#!/bin/sh -e

create_factor_packages

$PKG_CMD b 12
$PKG_CMD i 12
for _ in 1 2; do
    for i in 1 2 3 4 6; do
        $PKG_CMD tree 12 | grep "$i"
    done

    for i in 5 7 8 9 11; do
        $PKG_CMD tree 12 | grep -q -v "$i"
    done
    mkdir temp
    cd temp
done
