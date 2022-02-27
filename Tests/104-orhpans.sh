#!/bin/sh -e

create_factor_packages

$PKG_CMD b 1
$PKG_CMD i 1
$PKG_CMD depends 1
$PKG_CMD revdepends 0
$PKG_CMD orphans make


$PKG_CMD b 4
$PKG_CMD i 4
[ "$($PKG_CMD orphans)" = 4 ]

$PKG_CMD b 3
$PKG_CMD i 3
$PKG_CMD orphans | grep 3
$PKG_CMD orphans | grep 4
