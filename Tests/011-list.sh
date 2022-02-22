#!/bin/sh -e

$PKG_CMD list
$PKG_CMD new A
$PKG_CMD new B
$PKG_CMD new C
$PKG_CMD b A B C
$PKG_CMD i A B C

$PKG_CMD list A
$PKG_CMD list A | grep A
$PKG_CMD list A B | grep B
$PKG_CMD list A B | grep -v C
$PKG_CMD list A B C | grep A

mkdir temp
cd temp
$PKG_CMD list A | grep A
$PKG_CMD list A | grep -v B
$PKG_CMD list   | grep A
$PKG_CMD list   | grep B
$PKG_CMD list   | grep C

