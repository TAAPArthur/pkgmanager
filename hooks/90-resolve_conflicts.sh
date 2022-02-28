#!/bin/sh

PKGMANAGER_PREFERED_SOURCE_FILE=${PKGMANAGER_PREFERED_SOURCE_FILE:-/usr/share/pkgmanager/conflict/preferred_source.txt}

if [ -r "$PKGMANAGER_PREFERED_SOURCE_FILE" ]; then
    case "$TYPE" in
       post-install)
           grep "^$PKG\s" "$PKGMANAGER_PREFERED_SOURCE_FILE" | pkgmanager a -
           ;;
    esac
fi
