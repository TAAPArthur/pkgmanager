#!/bin/sh -e

case "$TYPE" in
   pre-build)
       IFS=. read -r _start _ < /proc/uptime
   ;;

   post-build)
       IFS=. read -r _end _ < /proc/uptime
       s=$((_end - _start))
       h=$((s / 60 / 60 % 24))
       m=$((s / 60 % 60))
       unset _pretty_time

       [ "$h" = 0 ] || _pretty_time="$_pretty_time${h}h "
       [ "$m" = 0 ] || _pretty_time="$_pretty_time${m}m "

       info "Build finished in ${_pretty_time:=${s}s}"
       mkdir -p "$PKGMAN_METADATA_BASE_INSTALL_DIR/$PKG/stats"
       printf "%s\t%s\n" "$s" "$_pretty_time" > "$PKGMAN_METADATA_BASE_INSTALL_DIR/$PKG/stats/build_time"
   ;;

   pre-install)
       mkdir -p "$PKGMAN_METADATA_BASE_INSTALL_DIR/$PKG/stats"
       printf "%s\t%s\n" "$(du -s . | cut -f1)" "$( { du -sh . || du -s . ; } | cut -f1)" > "$PKGMAN_METADATA_BASE_INSTALL_DIR/$PKG/stats/install_size"
       printf "%s\t%s\n" "$(date -u +%F_%H:%M:%S)" "$(date)" > "$PKGMAN_METADATA_BASE_INSTALL_DIR/$PKG/stats/install_time"
   ;;
esac


