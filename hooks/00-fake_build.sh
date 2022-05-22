#!/bin/sh -e

if [ "$PKGMAN_FAKE_BUILD" = 1 ]; then
    case "$TYPE" in
        pre-extract)
            exit 0
            ;;
        pre-build)
            cd -
            ;;
    esac
fi
