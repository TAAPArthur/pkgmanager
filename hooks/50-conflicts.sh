#!/bin/sh -e

case "$TYPE" in
    pre-install)
        find . | { if [ -r "$3" ]; then comm -23 - "$3"; else cat -; fi; } | while read -r path; do
            if [ -f "$path" ]; then
                path=${path#.}
                # If package is owned by another package
                if [ "$(pkgmanager owns "$path" || echo "$PKG")" != "$PKG" ]; then
                    debug handling conflict
                    # if you don't want conflict management either
                    # (1) exit with non-zero status to abort the install
                    # (2) rm "$path"
                    PKGMAN_ROOT="$PWD" pkgmanager swap-conflict "" "$path"
                fi
            fi
        done
        ;;
esac
