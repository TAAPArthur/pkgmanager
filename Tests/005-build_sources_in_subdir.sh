#!/bin/sh -e

FILE=$PWD/file
FILE2=$PWD/file2
touch "$FILE" "$FILE2"
$PKG_CMD new A 1 "file://$FILE dir1" "file://$FILE2 dir2"
{
echo "[ -d dir1 ]"
echo "[ -d dir2 ]"
echo "[ -e dir1/file ]"
echo "[ -e dir2/file2 ]"
} > A/build
$PKG_CMD b A
