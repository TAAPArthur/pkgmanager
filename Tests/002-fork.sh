#!/bin/sh -e

$PKG_CMD new A 2 source1
echo 'echo 1' > A/build

mkdir temp
cd temp
$PKG_CMD fork A
[ -d A ]
[ -x A/build ]
diff A/build ../A/build
diff A ../A
