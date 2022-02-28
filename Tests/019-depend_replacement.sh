#!/bin/sh -e

create_factor_packages
printf "6\t7\n4\t\n" >> "$PKGMAN_DEPEND_MAP_FILE"

$PKG_CMD b 12
$PKG_CMD i 12

$PKG_CMD l
for i in 0 1 7 12; do
    $PKG_CMD l | grep "^$i\s"
done

for i in 2 3 4 5 6 8; do
    $PKG_CMD l | grep "^$i\s" && exit 1
done
exit 0
