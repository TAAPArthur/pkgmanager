#!/bin/sh -e

$PKG_CMD help
$PKG_CMD -h
$PKG_CMD --help
$PKG_CMD list-ext | cut -f1 | xargs "$PKG_CMD" help
$PKG_CMD help build install fetch find fork search
