#!/bin/sh -e

$PKG_CMD new A
$PKG_CMD b A
$PKG_CMD i A
METADATA_DIR=$(pkgmanager get-metadata-install-dir A)
mkdir "$METADATA_DIR/dir"
mkdir "$METADATA_DIR/file"

$PKG_CMD r A

[ ! -e "$METADATA_DIR/file" ]
[ ! -e "$METADATA_DIR/dir" ]
