#!/bin/sh -e

case "$TYPE" in
    post-build)
        METADATA=$(PKGMAN_ROOT="$PWD" pkgmanager get-metadata-install-dir "$PKG")
        for dir in */sbin/* */bin/* */lib*/*; do
            if [ -d "$dir" ] || [ -f "$dir" ]; then
                find "$dir" -type f -exec readelf -d {} \; | sed -n "s/.*Shared library: \[\([^\]*\)]/\1/p" | while read -r lib; do
                    for path in $PKGMAN_ROOT/usr/lib/"$lib" $PKGMAN_ROOT/usr/lib/"$lib"; do
                        [ -f "$path" ] || continue
                        owner="$(pkgmanager owns "${path#"$PKGMAN_ROOT"}" || echo "$PKG")"
                        if [ "$owner" != "$PKG" ]; then
                            touch "$METADATA/depends"
                            echo "$owner" | sort -u - "$METADATA/depends" > .temp
                            mv .temp "$METADATA/depends"
                        fi
                    done
                done
            fi
        done
        ;;
esac

