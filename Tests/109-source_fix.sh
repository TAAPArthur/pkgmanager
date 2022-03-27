#!/bin/sh -e

$PKG_CMD new A 2.3 "file://$PWD/PACKAGE_VERSION_MAJOR_MINOR_ARCH"

file=A_2.3_2_3_$(uname -m)
touch "$file"
echo "ls -a; tree ..; [ -e $file ]" >> A/build
$PKG_CMD b A
