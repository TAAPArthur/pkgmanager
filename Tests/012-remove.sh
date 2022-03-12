#!/bin/sh -e

$PKG_CMD new A
echo 'cd $1; touch a b c; ln -s a e; mkdir x y z; touch x/x y/y z/z' >> A/build

$PKG_CMD b A
$PKG_CMD i A

METADATA_DIR=$(pkgmanager get-metadata-install-dir A)

[ -d "$METADATA_DIR" ]
[ 0"$($PKG_CMD revdepends A)" -eq 0 ]

for file in a b c e x/x y/y z/z; do
    [ -e "$PKGMAN_ROOT/$file" ]
done

$PKG_CMD r A

for file in a b c e x/x y/y z/z; do
    [ ! -e "$PKGMAN_ROOT/$file" ]
done

if $PKG_CMD l A ; then
    exit 2
fi

[ ! -e "$METADATA_DIR" ]
