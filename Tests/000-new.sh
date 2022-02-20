#!/bin/sh -e

verify_new() {
    pkg=$1
    version=${2:-1}
    sources=$3
    [ -d "$pkg" ]
    [ -x "$pkg/build" ]
    [ -r "$pkg/version" ]

    read -r v rep <"$pkg/version"
    [ "$v" = "$version" ]
    [ "$rep" = "1" ]

    if [ -n "$sources" ]; then
        [ -r "$pkg/sources" ]
        read -r s <"$pkg/sources"
        [ "$s" = "$sources" ]
    fi
}
test_new() {
    $PKG_CMD new "$@"
    verify_new "$@"
}
test_new A
test_new B 1
test_new C 2
test_new D 3 some_source
