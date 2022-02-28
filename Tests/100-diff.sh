#!/bin/sh -e

$PKG_CMD new A
echo '[ -e $1 ]' > A/build

mkdir temp
cd temp

$PKG_CMD fork A

$PKG_CMD diff A
echo '[ -e $1 ]' >> A/build

$PKG_CMD diff A && exit 1

cd A
$PKG_CMD diff && exit 1

$PKG_CMD diff . && exit 1

exit 0
