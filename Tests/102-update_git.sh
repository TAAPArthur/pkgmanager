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

hashA="$(cd git_repo; git rev-parse HEAD)"

[ -z "$($PKG_CMD outdated)" ]
echo y | $PKG_CMD update git
$PKG_CMD list A | grep "$hashA"

[ -z "$($PKG_CMD outdated)" ]
[ -z "$($PKG_CMD outdated git)" ]

( cd git_repo; git checkout -B "new_branch"; echo "B" > file; git add .; git -c user.name='Test' -c user.email='user@test.com' commit -m"2"; )

hashB="$(cd git_repo; git rev-parse HEAD)"
( cd git_repo; git checkout master)

[ -z "$($PKG_CMD outdated)" ]
[ -z "$($PKG_CMD outdated git)" ]

$PKG_CMD new B git "git+file://$PWD/git_repo@new_branch"
$PKG_CMD b B
$PKG_CMD i B

$PKG_CMD list A | grep "$hashA"
$PKG_CMD list B | grep "$hashB"

[ -z "$($PKG_CMD outdated git)" ]
