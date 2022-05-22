#!/bin/sh -e

$PKG_CMD new A
echo '[ "$DESTDIR" = "$1" ]' >> A/build
$PKG_CMD b A
