#!/bin/sh -e

create_factor_packages

$PKG_CMD i 12

$PKG_CMD list 1 2 3 4 6 12
