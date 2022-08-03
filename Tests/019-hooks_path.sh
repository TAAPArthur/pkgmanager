#!/bin/sh -e

mkdir hooks.d
export PKGMAN_HOOK_PATH="$PKGMAN_HOOK_PATH:$PWD/hooks.d"


SOURCE_FILE=source_file
TARGET_FILE=usr/bin/target_file
cat >>hooks.d/hook.sh <<EOF
case "\$TYPE" in
    post-build  | pre-install) [ -e "$TARGET_FILE" ];;

    pre-extract) PRE_DIR=\$PWD; touch marker ;;
    post-extract ) [ "\$PRE_DIR" = "\$PWD" ]; [ -e marker ]; [ -e "$SOURCE_FILE" ]; ;;
    pre-build ) [ -e "$SOURCE_FILE" ];;

    post-install)  [ -e version ];;
    pre-remove)  PRE_DIR=\$PWD; [ -e version ] ;;
    post-remove )  [ "\$PRE_DIR" = "\$PWD" ] ;;
    *) exit 100;;
esac
EOF

touch "$SOURCE_FILE"
$PKG_CMD new A 1 "file://$PWD/$SOURCE_FILE"
echo 'mkdir -p "$DESTDIR/'${TARGET_FILE%/*}'"; mv source_file "$DESTDIR/'$TARGET_FILE'"' >> A/build

mkdir temp && cd temp
$PKG_CMD b A
$PKG_CMD i A
$PKG_CMD r A
