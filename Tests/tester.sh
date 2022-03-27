#!/bin/sh -e

WORKING_DIR="$(mktemp -d)"
trap "rm -rf $WORKING_DIR" EXIT

export PKG_CMD=pkgmanager
export PKGMAN_PATH="$WORKING_DIR"

timeout() {
    # timeout isn't a standard util, do just run the command
    # normally without it
    if cmd="$(which timeout)" ; then
        $cmd "$@"
    else
        shift
        "$@"
    fi
}

PATH=$PWD:$PATH

export PKGMAN_HOOK_PATH="$PWD/hooks"
export PKGMAN_SOURCE_FIX_FILE="$PWD/compatibility/source_fix"

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
    echo "$PKG_CMD list 1 || { echo depend '1' is not installed; exit 64; }" | tee -a 2/build 3/build >/dev/null
    echo "$PKG_CMD list 0 || { echo make depend '0' is not installed; exit 64; }" >> 1/build
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
        export PKGMAN_DEPEND_MAP_FILE="$WORKING_DIR/alias_file"
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
