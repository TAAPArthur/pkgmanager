#!/bin/sh -e


$PKG_CMD new foo

cat - >>foo/build <<"EOF"
echo "int foo(){return 0;}" > dummy.c
cc -fPIC -shared -o libdummy.so dummy.c
mkdir -p "$1"/usr/lib
mv libdummy.so "$1"/usr/lib/
EOF

$PKG_CMD new bar

cat - >>bar/build <<"EOF"
echo "int foo(); int main(){return foo();}" > dummy2.c
cc -o dummy  dummy2.c -ldummy
mkdir -p "$1"/usr/bin
mv dummy "$1"/usr/bin/
EOF
export LIBRARY_PATH="$PKGMAN_ROOT/usr/lib"

$PKG_CMD b foo
$PKG_CMD i foo
$PKG_CMD b bar
$PKG_CMD i bar
set -x

$PKG_CMD depends bar
$PKG_CMD depends bar | grep foo

