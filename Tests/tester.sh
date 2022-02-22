#!/bin/sh -e

WORKING_DIR="$(mktemp -d)"
trap "rm -rf $WORKING_DIR" EXIT

export PKG_CMD=pkgmanager
export PKGMAN_PATH="$WORKING_DIR"


PATH=$PWD:$PATH

create_factor_packages() {
    for i in $(seq 1 "${1:-12}"); do
        $PKG_CMD new "$i"
        for n in $(seq "$((i-1))" -1 1); do
            if [ "$((i%n))" -eq 0 ]; then
                [ -e blacklist ] && grep -x -q "$n" blacklist && continue
                echo "$n" >> "$i/depends"
                [ -e "$n/depends" ] && cat "$n/depends" >> blacklist
            fi
        done
        rm -f blacklist
    done
}
run_test() {
    set -e
    . "$1"
}
for test_file in Tests/*-*.sh; do
    mkdir -p "$WORKING_DIR"
    (
        f="$PWD/$test_file"
        cd "$WORKING_DIR"
        export HOME="$WORKING_DIR/home"
        export PKGMAN_ROOT="$WORKING_DIR/fakeroot"
        mkdir -p "$PKGMAN_ROOT"

        printf "%s..." "${f#"$OLDPWD/"}"
        if ! ( run_test "$f" ) > test.out 2>&1; then
            echo failed
            cat test.out
            echo "$f failed"
            exit 1
        else
            echo passed
        fi
    )
    rm -rf "$WORKING_DIR"
done
