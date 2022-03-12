#!/bin/sh -e

$PKG_CMD new A
set -x
echo 'exit 20' >> A/build
$PKG_CMD b A && exit 1
exit 0
