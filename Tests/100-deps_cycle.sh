#!/bin/sh -x


$PKG_CMD new foo
$PKG_CMD new bar
echo foo > bar/depends
echo bar > foo/depends

$PKG_CMD b bar && exit 1
$PKG_CMD b foo && exit 1
$PKG_CMD b foo bar && exit 1


$PKG_CMD new self
echo self > self/depends

$PKG_CMD b self && exit 1

exit 0
