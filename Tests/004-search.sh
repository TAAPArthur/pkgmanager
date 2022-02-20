#!/bin/sh -e

! $PKG_CMD s A || exit 1

$PKG_CMD new A
$PKG_CMD s A
