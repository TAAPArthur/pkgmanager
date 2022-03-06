#!/bin/sh -e

$PKG_CMD list-ext | sort -u > sorted_list
$PKG_CMD list-ext | sort | diff -q - sorted_list
