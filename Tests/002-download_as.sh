#!/bin/sh -e

FILE=$PWD/file
touch "$FILE"
$PKG_CMD new A 1 "file://$FILE"
$PKG_CMD dowload A

set -x


rm "$FILE"
$PKG_CMD new B 1 "file://$FILE"

# should fail be FILE doesn't exist
$PKG_CMD dowload B && exit 1

echo "A" > B/downloadas
# should pass because A's cached file can be found
$PKG_CMD dowload B
