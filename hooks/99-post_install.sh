#!/bin/sh

case "$TYPE" in
   post-install)
       [ ! -r post_install ] || cat post-install
       ;;
esac
