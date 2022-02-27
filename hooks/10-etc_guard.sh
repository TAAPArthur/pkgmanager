#!/bin/sh -e
# Don't override top level files in etc

case "$TYPE" in
    pre-install)
        for file in etc/*; do
            if [ -f "$file" ] && [ -e "$PKGMAN_ROOT/$file" ]; then
                if [ "$(pkgmanager owns "/$file" || echo "$PKG")" = "$PKG" ]; then
                    echo "/$file" > "$WORKING_DIR/post_manifest"
                fi
                rm "$file"
                [ ! -e "$PREVIOUS_MANIFEST" ] || sed -i "s:^/$file\$::; /^\$/d" "$PREVIOUS_MANIFEST"
            fi
        done
        ;;
    post-install)
        echo $PWD
        if [ -e "$WORKING_DIR/post_manifest" ]; then
            sort "$WORKING_DIR/post_manifest" manifest > "$WORKING_DIR/temp"
            mv "$WORKING_DIR/temp" manifest
        fi
esac
