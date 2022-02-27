#!/bin/sh -e

WORKING_DIR="$(mktemp -d)"
trap "rm -rf $WORKING_DIR" EXIT

export PKG_CMD=pkgmanager
export PKGMAN_PATH="$WORKING_DIR"


PATH=$PWD:$PATH

export PKGMAN_HOOK_PATH="$PWD/hooks"

create_factor_packages() {
    $PKG_CMD new 0
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
    echo 0 make >> 1/depends
    echo "$PKG_CMD list | grep '^1\s' || { echo depend '1' is not installed; exit 64; }" | tee -a 2/build 3/build >/dev/null
    echo "$PKG_CMD list | grep 0 || { echo make depend '0' is not installed; exit 64; }" >> 1/build
}

run_test() {
    set -e
    . "$1"
}
for test_file in Tests/"$1"*-*.sh; do
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
