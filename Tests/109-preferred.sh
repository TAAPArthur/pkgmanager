#!/bin/sh -e

export PKGMANAGER_PREFERED_SOURCE_FILE="$PWD/preferred_file"

$PKG_CMD new A
$PKG_CMD new B
$PKG_CMD new C

echo 'touch $1/file' | tee -a A/build B/build C/build

$PKG_CMD b A B C
$PKG_CMD i A B C

$PKG_CMD a | grep B | $PKG_CMD a -
[ "$($PKG_CMD owns /file)" = B ]

$PKG_CMD preferred > "$PKGMANAGER_PREFERED_SOURCE_FILE"

$PKG_CMD r A B C

$PKG_CMD i A

[ "$($PKG_CMD owns /file)" = A ]

$PKG_CMD i C

[ "$($PKG_CMD owns /file)" = A ]

$PKG_CMD i B

[ "$($PKG_CMD owns /file)" = B ]

$PKG_CMD i B

[ "$($PKG_CMD owns /file)" = B ]
