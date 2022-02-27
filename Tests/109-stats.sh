#!/bin/sh

$PKG_CMD new A
$PKG_CMD b A
$PKG_CMD i A
$PKG_CMD stats build_time A
$PKG_CMD stats install_size A
$PKG_CMD stats install_time A
