#!/bin/sh -e

mkdir -p pkg/A/B/C/D
touch pkg/b pkg/c

tar -c pkg > pkg.tar

$PKG_CMD new A 1 "file://$PWD/pkg.tar"


mkdir -p temp
cd temp
set -xe
$PKG_CMD e A
cd A
ls

[ -d A ]
[ -e b ]
[ -e c ]
[ -d A/B/C/D ]
[ ! -d pkg ]
