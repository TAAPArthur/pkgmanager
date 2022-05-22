#!/bin/sh

# Some packages are misconfigured and assume DESTDIR is set in the environment
case "$TYPE" in
   pre-build)
       export DESTDIR="$DEST_DIR"
       ;;
esac
