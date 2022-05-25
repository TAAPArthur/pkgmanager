#!/bin/sh -e

$PKG_CMD new A 1
cat - >> A/build <<"EOF"
for i in $(seq 1 12); do
touch $1/$i
done
EOF
$PKG_CMD b A
$PKG_CMD i A
MANIFEST_FILE=$($PKG_CMD get-metadata-install-dir)/A/manifest

run_test() {
    [ -e "$MANIFEST_FILE.bk" ] && mv "$MANIFEST_FILE.bk" "$MANIFEST_FILE"

    $PKG_CMD b A
    $PKG_CMD i A

    for i in $(seq 1 12); do
        [ -e "$PKGMAN_ROOT/$i" ]
    done
}

run_test

sort -r "$MANIFEST_FILE" > "$MANIFEST_FILE.bk"
run_test

sort -n "$MANIFEST_FILE" > "$MANIFEST_FILE.bk"
run_test

