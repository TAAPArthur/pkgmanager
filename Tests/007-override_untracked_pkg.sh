#!/bin/sh -e


PATH1=some_file
PATH2=/usr/bin/file
PATH3=/usr/bin/file2

set -x
echo 1 > "$PKGMAN_ROOT/$PATH1"
mkdir -p "$(dirname "$PKGMAN_ROOT/$PATH2")"
echo 2 > "$PKGMAN_ROOT/$PATH2"
ln -s "$PKGMAN_ROOT/$PATH2" "$PKGMAN_ROOT/$PATH3"
$PKG_CMD new A
{
    set -x
echo "echo 3 > \$1/$PATH1"
echo "mkdir -p \$(dirname \$1/$PATH2)"
echo "echo 4 > \$1/$PATH2"
echo tree \$1
echo ln -s "\$1/$PATH2" "\$1/$PATH3"
} >> A/build

$PKG_CMD b A
$PKG_CMD i A
read -r value < "$PKGMAN_ROOT/$PATH1"
[ "$value" -eq 3 ]

read -r value < "$PKGMAN_ROOT/$PATH2"
[ "$value" -eq 4 ]
