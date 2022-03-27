#!/bin/sh

$PKG_CMD new A
cat - >> A/build <<"EOF"
for i in $(seq 1 1000); do
    touch "$1/$i"
done
EOF
$PKG_CMD b A
timeout 2 "$PKG_CMD" i A

[ "$($PKG_CMD owns "/1000")" = A ]

timeout 2 "$PKG_CMD" i A

[ "$($PKG_CMD owns "/1000")" = A ]

for i in $(seq 1 1000); do
    [ -e "$PKGMAN_ROOT/$i" ]
done
