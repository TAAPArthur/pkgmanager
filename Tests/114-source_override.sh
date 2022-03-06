#!/bin/sh -e

mkdir git_repo
( cd git_repo; git init; echo git | tee file1 file2; git add .; git -c user.name='Test' -c user.email='user@test.com' commit -m"Init")
echo remote | tee file2 file3

mkdir tarDir
echo tar | tee tarDir/file3 tarDir/file4
tar -c tarDir > tarFile.tar

$PKG_CMD new A 1 "git+file://$PWD/git_repo" "file://$PWD/file2" "file://$PWD/file3" "file://$PWD/tarFile.tar" "files/file4" "files/file5"

mkdir A/files
echo included | tee A/files/file4 A/files/file5
tree A
cat A/sources

cat - <<EOF >> A/build
set -xe
echo git | diff -q - file1
echo remote | diff -q - file2
echo tar | diff -q - file3
echo included | diff -q - file4
echo included | diff -q - file5
EOF

$PKG_CMD b A
$PKG_CMD i A
