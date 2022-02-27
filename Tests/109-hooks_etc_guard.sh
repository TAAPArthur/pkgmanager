#!/bin/sh -e

$PKG_CMD new A
$PKG_CMD new B
$PKG_CMD new C
echo 'mkdir "$1/etc/"; echo A > "$1/etc/file"' > A/build
echo 'mkdir "$1/etc/"; echo B > "$1/etc/file"' > B/build
echo 'mkdir "$1/etc/"; echo C > "$1/etc/file"' > C/build


$PKG_CMD b A B C
$PKG_CMD i B A C

[ -e "$PKGMAN_ROOT/etc/file" ]
[ "$($PKG_CMD owns "/etc/file")" = B ]

$PKG_CMD manifest A C | grep -q file && exit 1

verify() {
    [ -e "$PKGMAN_ROOT/etc/file" ]
    [ "$($PKG_CMD owns "/etc/file")" = "$1" ]
    read -r value < "$PKGMAN_ROOT/etc/file"
    [ "$value" = "${2:-"$1"}" ]
}

$PKG_CMD r B

[ ! -e "$PKGMAN_ROOT/etc/file" ]


$PKG_CMD i A C
verify A

$PKG_CMD r C
verify A

echo "A2" > "$PKGMAN_ROOT/etc/file"
$PKG_CMD i A
verify A A2

$PKG_CMD r A

[ ! -e "$PKGMAN_ROOT/etc/file" ]
