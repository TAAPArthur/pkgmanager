#!/bin/sh -e
# Don't override top level files in etc

case "$TYPE" in
    pre-install)
        for file in etc/*; do
            if [ -f "$file" ] && [ -e "$PKGMAN_ROOT/$file" ]; then
                if [ "$(pkgmanager owns "/$file" || echo "$PKG")" = "$PKG" ]; then
                    echo "/$file" > "$WORKING_DIR/post_manifest"
                fi
                info "Not updating $file"
                rm "$file"
                [ ! -e "$PREVIOUS_MANIFEST" ] || sed -i "s:^/$file\$::; /^\$/d" "$PREVIOUS_MANIFEST"
            fi
        done
        ;;
    post-install)
        if [ -e "$WORKING_DIR/post_manifest" ]; then
            pkgmanager update-manifest manifest "$WORKING_DIR/post_manifest"
        fi
esac
