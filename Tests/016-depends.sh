#!/bin/sh -e

create_factor_packages

$PKG_CMD b 4
$PKG_CMD i 4
mkdir dummy
cd dummy
check() {
    pkg=$1
    for i in $(seq 1 12); do
        echo "Checking $i"
        if grep -q "$i" "../$pkg/depends"; then
            $PKG_CMD depends "$pkg" | grep "$i"
        else
            $PKG_CMD depends "$pkg" | grep -v "$i"
        fi
    done
}

check 2
check 4
check 8
check 12
