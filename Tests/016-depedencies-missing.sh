#!/bin/sh -e

$PKG_CMD new A
echo "B" >> A/depends

! $PKG_CMD b A || exit 1
$PKG_CMD b A 2>&1 | grep B
