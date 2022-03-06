#!/bin/sh -e


mkdir git_repo
( cd git_repo; git init; touch gitFile; git add .; git -c user.name='Test' -c user.email='user@test.com' commit -m"Init")

mkdir tarDir
touch tarDir/tarFile
tar -c tarDir > tarFile.tar


mkdir tarDirCompressed
touch tarDirCompressed/tarFileCompressed
tar -c tarDirCompressed | gzip > tarFile.tar.gz
tar -tf  tarFile.tar.gz


mkdir zipDir
touch zipDir/zipFile

zip -r zipFile zipDir


$PKG_CMD new A 1 "git+file://$PWD/git_repo" "file://$PWD/tarFile.tar" "file://$PWD/tarFile.tar.gz" "file://$PWD/zipFile.zip" "files/file"
mkdir A/files
touch A/files/file

cat - <<EOF >> A/build
set -ex
[ -r gitFile ]
[ -r tarFile ]
[ -r tarFileCompressed ]
[ -r zipFile ]
EOF

$PKG_CMD b A
$PKG_CMD i A


