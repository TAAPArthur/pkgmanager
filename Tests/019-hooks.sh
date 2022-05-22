#!/bin/sh -e

mkdir hooks.d
export PKGMAN_HOOK_PATH="$PKGMAN_HOOK_PATH:$PWD/hooks.d"
cat >>hooks.d/hook.sh <<"EOF"
touch $PKGMAN_ROOT/$TYPE
case "$TYPE" in
    post-build  ) [ "$p_build" -eq 1 ];;
    post-extract ) [ "$p_extract" -eq 1 ];;
    post-install)  [ "$p_install" -eq 1 ];;
    post-remove )  [ "$p_remove" -eq 1 ];;
    pre-build   ) p_build=1;;
    pre-extract )  p_extract=1;;
    pre-install )  p_install=1;;
    pre-remove  )  p_remove=1;;
    *) exit 100;;
esac
EOF

cat >>hooks.d/99-sanity.sh <<EOF
touch $PWD/foo
EOF


create_factor_packages 4
$PKG_CMD b 4
$PKG_CMD i 4
$PKG_CMD fetch
$PKG_CMD r 4

[ -e foo ]
for type in post-build post-install post-remove pre-build pre-install pre-remove; do
    [ -e "$PKGMAN_ROOT/$type" ]
done
