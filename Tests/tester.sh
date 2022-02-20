#!/bin/sh -e

WORKING_DIR="$(mktemp -d)"
trap "rm -rf $WORKING_DIR" EXIT

export PKG_CMD=pkgmanager
export PKGMAN_PATH="$WORKING_DIR"


PATH=$PWD:$PATH
for test_file in Tests/*-*.sh; do
    mkdir -p "$WORKING_DIR"
    (
        f="$PWD/$test_file"
        cd "$WORKING_DIR"
        export HOME="$WORKING_DIR/home"
        export PKGMAN_ROOT="$WORKING_DIR/fakeroot"
        mkdir -p "$PKGMAN_ROOT"

        printf "%s..." "${f#"$OLDPWD/"}"
        if ! "$f" > test.out 2>&1; then
            echo failed
            cat test.out
            exit 1
        else
            echo passed
        fi
    )
    rm -rf "$WORKING_DIR"
done
