#!/bin/sh -e

$PKG_CMD new AAAB
[ "$(basename "$($PKG_CMD s "A.*")")" = AAAB ]
[ "$(basename "$($PKG_CMD s ".*B")")" = AAAB ]
[ "$(basename "$($PKG_CMD s "AAAB/")")" = AAAB ]
[ "$(basename "$($PKG_CMD s "$PWD/AAAB/")")" = AAAB ]
! $PKG_CMD s "A" || exit 1
! $PKG_CMD s "B" || exit 1
! $PKG_CMD s "badname" || exit 1
