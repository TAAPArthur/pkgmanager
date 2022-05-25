#!/bin/sh -e


$PKG_CMD new A 1
echo 'echo 0 > $1/file' >> A/build
$PKG_CMD b A
$PKG_CMD i A

export PKGMAN_HOOK_PATH="$PKGMAN_HOOK_PATH:$PWD/hooks"
mkdir hooks
cat - >>hooks/999-fail_pre_install_hook.sh <<"EOF"
case "$TYPE" in
    pre-install)
        exit 1
esac
EOF

echo 0 > "$PKGMAN_ROOT/file2"

$PKG_CMD new B 1
echo 'echo 1 | tee $1/file $1/file2' >> B/build
$PKG_CMD b B
$PKG_CMD i B || true

for f in file file2; do
    [ -e "$PKGMAN_ROOT/$f" ]
    read -r var < "$PKGMAN_ROOT/$f"
    [ "$var" -eq 0 ]
done
