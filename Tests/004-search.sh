#!/bin/sh -e

$PKG_CMD new AAAB
[ "$(basename "$($PKG_CMD s "A.*")")" = AAAB ]
[ "$(basename "$($PKG_CMD s ".*B")")" = AAAB ]
! $PKG_CMD s "badname" || exit 1
