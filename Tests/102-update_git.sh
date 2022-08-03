#!/bin/sh -e

mkdir git_repo
( cd git_repo; git init; touch file; git add .; git -c user.name='Test' -c user.email='user@test.com' commit -m"Init")

$PKG_CMD new A git "git+file://$PWD/git_repo"
$PKG_CMD b A
$PKG_CMD i A

hash="$(cd git_repo; git rev-parse HEAD)"
$PKG_CMD list A
$PKG_CMD list A | grep "$hash"


( cd git_repo; echo "A" > file; git add .; git -c user.name='Test' -c user.email='user@test.com' commit -m"2")


hash="$(cd git_repo; git rev-parse HEAD)"

[ -z "$($PKG_CMD outdated)" ]
echo y | $PKG_CMD update git
$PKG_CMD list A
$PKG_CMD list A | grep "$hash"

[ -z "$($PKG_CMD outdated)" ]
[ -z "$($PKG_CMD outdated git)" ]
