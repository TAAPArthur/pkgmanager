#!/bin/sh -x

$PKG_CMD new 1
mkdir single_pkg
echo "1 1" > single_pkg/version
$PKG_CMD b single_pkg

mkdir pkg_with_depends
echo "1 1" > pkg_with_depends/version
echo "single_pkg" > pkg_with_depends/depends

$PKG_CMD b pkg_with_depends
$PKG_CMD i pkg_with_depends

$PKG_CMD list | grep pkg_with_depends
$PKG_CMD list | grep single_pkg
