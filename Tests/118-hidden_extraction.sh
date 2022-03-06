#!/bin/sh -e

mkdir git_repo
( cd git_repo; git init; touch .gitFile; git add .; git -c user.name='Test' -c user.email='user@test.com' commit -m"Init")
touch .hiddenFile


mkdir tarDir
touch tarDir/.tarFile
tar -c tarDir > tarFile.tar

$PKG_CMD new A 1 "git+file://$PWD/git_repo" "file://$PWD/.hiddenFile" "file://$PWD/tarFile.tar" "files/.file"

mkdir A/files
touch A/files/.file

cat - <<EOF >> A/build
[ -r .file ]
[ -r .hiddenFile ]
[ -r .gitFile ]
[ -r .tarFile ]
EOF

$PKG_CMD b A
$PKG_CMD i A
