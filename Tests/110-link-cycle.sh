#!/bin/sh -e

$PKG_CMD new A

cat >>A/build <<"EOF"
DIR="$1/DIR/"
mkdir -p "$DIR"
ln -s "$DIR" "$DIR/child"
touch "$DIR/file"
EOF

cp -R A B

$PKG_CMD b A
$PKG_CMD i A

$PKG_CMD b B
$PKG_CMD i B
