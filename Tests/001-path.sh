#!/bin/sh -e


$PKG_CMD new A
export PKGMAN_PATH="bad_dir:$PKGMAN_PATH:bad_dir2"
$PKG_CMD s A
$PKG_CMD b A
