#!/bin/sh -e

$PKG_CMD new A
$PKG_CMD b A
$PKG_CMD i A
set -x
echo "1 2" > A/version
$PKG_CMD outdated A | grep "A"
