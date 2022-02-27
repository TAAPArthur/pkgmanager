#!/bin/sh -e


$PKG_CMD repo-orphans
$PKG_CMD new A
$PKG_CMD b A
$PKG_CMD i A

[ -z "$($PKG_CMD repo-orphans)" ]

unset PKGMAN_PATH

$PKG_CMD list | grep A
$PKG_CMD repo-orphans | grep A
