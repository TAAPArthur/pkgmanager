#!/bin/sh -e

$PKG_CMD new A
$PKG_CMD new B
$PKG_CMD b A B
$PKG_CMD i A B
mkdir temp
cd temp
set -x
$PKG_CMD outdated
[ -z "$($PKG_CMD outdated)" ]
echo "1 2" > ../A/version
$PKG_CMD outdated A | grep "A"
$PKG_CMD outdated A | grep -v "B"
