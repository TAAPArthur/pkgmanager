#!/bin/sh -e

case "$TYPE" in
    post-build)
        METADATA=$(PKGMAN_ROOT="$PWD" pkgmanager get-metadata-install-dir "$PKG")
        TEMP_DEPENDS="$WORKING_DIR/.temp"
        for dir in */sbin/* */bin/* */lib*/*; do
            if [ -e "$dir" ]; then
                find "$dir" -type f -exec readelf -d {} \; 2>/dev/null | sed -n "s/.*Shared library: \[\([^\]*\)]/\1/p" | while read -r lib; do
                    for path in $PKGMAN_ROOT/usr/lib/"$lib" $PKGMAN_ROOT/usr/lib/"$lib"; do
                        [ -f "$path" ] || continue
                        owner="$(pkgmanager owns "${path#"$PKGMAN_ROOT"}" || echo "$PKG")"
                        if [ "$owner" != "$PKG" ]; then
                            echo "$owner" >> "$TEMP_DEPENDS"
                        fi
                    done
                done
            fi
        done
        if [ -e "$TEMP_DEPENDS" ]; then
            touch "$METADATA/depends"
            sort -u "$METADATA/depends" "$TEMP_DEPENDS" > "${TEMP_DEPENDS}.temp"
            diff -u "$METADATA/depends" "${TEMP_DEPENDS}.temp" || mv "${TEMP_DEPENDS}.temp" "$METADATA/depends"
        fi
        ;;
esac

