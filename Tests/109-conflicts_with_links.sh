#!/bin/sh

$PKG_CMD new A
$PKG_CMD new B
$PKG_CMD new C

cat - <<"EOF" | tee A/build B/build C/build >/dev/null
mkdir -p $1/bin/
touch $1/bin/$PKG
chmod +x $1/bin/$PKG
ln -s $PKG $1/bin/cmd
EOF

$PKG_CMD b A B C

$PKG_CMD i B A C
validate() {
    for pkg in A B C; do
        [ -x "$PKGMAN_ROOT/bin/$pkg" ]
        [ "$($PKG_CMD owns "/bin/$pkg")" = "$pkg" ]
    done
    [ "$(readlink "$PKGMAN_ROOT/bin/cmd")" = "$1" ]
}
validate B

$PKG_CMD a | grep A | $PKG_CMD a -

validate A

for cmd in A B C; do
    $PKG_CMD i "$cmd"
    validate A
done

$PKG_CMD a | grep B | $PKG_CMD a -
validate B

for cmd in A B C; do
    $PKG_CMD i "$cmd"
    validate B
done

$PKG_CMD a | grep C | $PKG_CMD a -
validate C
