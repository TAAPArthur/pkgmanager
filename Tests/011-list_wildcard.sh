#!/bin/sh -e

$PKG_CMD new AAA
$PKG_CMD new AAB
$PKG_CMD new ABA

$PKG_CMD b AAA AAB ABA
$PKG_CMD i AAA AAB ABA

[ "$($PKG_CMD list "A")" = "" ]
$PKG_CMD list "A.*"  | grep AAA

$PKG_CMD list "A.*"  | grep AAB
$PKG_CMD list ".*B.*" | grep ABA
