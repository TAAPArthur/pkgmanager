#!/bin/sh -e

$PKG_CMD new A
$PKG_CMD new B
echo "# Comment" | tee -a A/sources A/depends A/version
echo "" | tee -a B/sources B/depends B/version

$PKG_CMD b A

$PKG_CMD b B

