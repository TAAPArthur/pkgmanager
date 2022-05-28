#!/bin/sh -e

case "$TYPE" in
    post-build)
        METADATA=$(PKGMAN_ROOT="$PWD" pkgmanager get-metadata-install-dir "$PKG")
        TEMP_DEPENDS="$WORKING_DIR/.temp"
        find usr/ -type f -perm 755 -exec readelf -d {} \+ 2>/dev/null | sed -n "s/.*Shared library: \[\([^\]*\)]/\1/p" | sort -u |
            while read -r lib; do
                find "$PKGMAN_ROOT/usr/lib" -type f -name "$lib" | while read -r path; do
                    owner="$(pkgmanager owns "${path#"$PKGMAN_ROOT"}" || echo "$PKG")"
                    if [ "$owner" != "$PKG" ]; then
                        echo "$owner" >> "$TEMP_DEPENDS"
                    fi
                done
            done
        if [ -e "$TEMP_DEPENDS" ]; then
            touch "$METADATA/depends"
            sort -u "$METADATA/depends" "$TEMP_DEPENDS" > "${TEMP_DEPENDS}.temp"
            diff -u "$METADATA/depends" "${TEMP_DEPENDS}.temp" || mv "${TEMP_DEPENDS}.temp" "$METADATA/depends"
        fi
        ;;
esac

