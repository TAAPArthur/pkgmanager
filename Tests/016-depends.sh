#!/bin/sh -e

create_factor_packages

$PKG_CMD b 4
$PKG_CMD i 4
$PKG_CMD depends 4
for i in $(seq 1 12); do
    echo "Checking $i"
    if grep -q "$i" 4/depends; then
        $PKG_CMD depends 4 | grep "$i"
    else
        $PKG_CMD depends 4 | grep -v "$i"
    fi
done
