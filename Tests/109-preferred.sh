#!/bin/sh -e

export PKGMANAGER_PREFERED_SOURCE_FILE="$PWD/preferred_file"

$PKG_CMD new A
$PKG_CMD new B
$PKG_CMD new C

{
echo 'echo $PKG > $1/file'
echo 'ln -s file $1/file2'
} | tee -a A/build B/build C/build

$PKG_CMD b A B C
$PKG_CMD i A B C

[ "$($PKG_CMD owns /file)" = A ]
[ "$($PKG_CMD owns /file2)" = A ]

$PKG_CMD a | grep A && exit 1
$PKG_CMD a | grep B
$PKG_CMD a | grep C
$PKG_CMD a | grep B | $PKG_CMD a -
[ "$($PKG_CMD owns /file)" = B ]
[ "$($PKG_CMD owns /file2)" = B ]

$PKG_CMD preferred > "$PKGMANAGER_PREFERED_SOURCE_FILE"

$PKG_CMD r A B C

$PKG_CMD i A

validate() {
    [ "$($PKG_CMD owns /file)" = "$1" ]
    $PKG_CMD owns /file2
    [ "$($PKG_CMD owns /file2)" = "$1" ]
    read -r value < "$PKGMAN_ROOT/file"
    [ "$value" = "${2:-$1}" ]
    read -r value2 < "$PKGMAN_ROOT/file2"
    [ "$value2" = "${2:-$1}" ]
}

validate A

$PKG_CMD i C

validate A

$PKG_CMD i B
validate B
$PKG_CMD i B
validate B
echo D > "$PKGMAN_ROOT/file"
validate B D

$PKG_CMD r B
[ ! -e "$PKGMAN_ROOT/file" ]

$PKG_CMD i A
validate A
