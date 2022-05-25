#!/bin/sh -e

$PKG_CMD new A 1
echo 'touch $1/A' >> A/build
$PKG_CMD b A
$PKG_CMD i A

$PKG_CMD list A | grep "1 1"

export PKGMAN_HOOK_PATH="$PWD/hooks"
mkdir hooks
cat - >>hooks/fail_post_install_hook.sh <<"EOF"
case "$TYPE" in
    post-install)
        exit 1
esac
EOF

echo "2 2" > A/version
echo 'touch $1/B' >> A/build
$PKG_CMD new B
$PKG_CMD b A B
$PKG_CMD i A || true
$PKG_CMD i B || true
! $PKG_CMD list B || exit 1
! $PKG_CMD manifest B || exit 1

$PKG_CMD manifest A | grep -x /B && exit 1
$PKG_CMD manifest A | grep -x /A
$PKG_CMD list A
$PKG_CMD list A | grep 2 && exit 1
$PKG_CMD list A | grep "1 1"
