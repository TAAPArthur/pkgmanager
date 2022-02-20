#!/bin/sh -e

! $PKG_CMD f A || exit 1

$PKG_CMD new A
$PKG_CMD f A
