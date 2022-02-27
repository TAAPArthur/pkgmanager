#!/bin/sh -e

create_factor_packages

$PKG_CMD b 1
$PKG_CMD i 1

$PKG_CMD depends 1    | grep -q make
$PKG_CMD revdepends 0 | grep -q make
[ -z "$($PKG_CMD revdepends 1)" ]
$PKG_CMD revdepends 0 | grep "\tmake\$"
$PKG_CMD revdepends 0 | grep -v "\tmake\$" || true
$PKG_CMD revdepends 0 | grep -v "\tmake\$" || true

[ "$($PKG_CMD orphans)" = 1 ]
[ "$($PKG_CMD orphans make | head -n1)" = 0 ]


$PKG_CMD b 4
$PKG_CMD i 4
[ "$($PKG_CMD orphans)" = 4 ]

$PKG_CMD b 3
$PKG_CMD i 3
$PKG_CMD orphans | grep 3
$PKG_CMD orphans | grep 4
