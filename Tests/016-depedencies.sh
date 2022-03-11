#!/bin/sh -e


create_factor_packages

# poison 7
echo "exit 2" >> 7/build

mkdir temp;
( cd temp; $PKG_CMD b 12 )

$PKG_CMD l 1 2 3 4 6

# We should use the cache for future installs
rm -rf 1 2 3 4 6
$PKG_CMD i 12

$PKG_CMD b 9 10
$PKG_CMD i 9 10
