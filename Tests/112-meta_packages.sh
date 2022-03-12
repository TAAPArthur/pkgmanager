#!/bin/sh -e

create_factor_packages

$PKG_CMD new __meta__
printf "7\n12\n" >> __meta__/depends

$PKG_CMD b __meta__
$PKG_CMD l 7 12
