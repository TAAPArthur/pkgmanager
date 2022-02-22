#!/bin/sh -ex
! $PKG_CMD find A || exit 1

$PKG_CMD new A
$PKG_CMD find A
