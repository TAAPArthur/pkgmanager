#!/bin/sh -e

create_factor_packages 14
printf "s/6/7/\n/4/d\n" >> "$PKGMAN_DEPEND_MAP_FILE"

for _ in 1 2; do
    $PKG_CMD b 12
    $PKG_CMD i 12

    $PKG_CMD l
    for i in 0 1 7 12; do
        $PKG_CMD l | grep "^$i\s"
    done

    for i in 2 3 4 5 6 8; do
        $PKG_CMD l | grep "^$i\s" && exit 1
        ! $PKG_CMD depends 12 | grep -x "$i" || exit 1
    done

    ! $PKG_CMD depends 12 | grep "6" || exit 1
    $PKG_CMD depends 12 | grep "7"
    ! $PKG_CMD depends 8 | grep "4" || exit 1
done

rm -f "$PKGMAN_DEPEND_MAP_FILE"

! $PKG_CMD depends 12 | grep "6" || exit 1
$PKG_CMD depends 12 | grep "7"

$PKG_CMD depends 12 8 | grep "4"

printf "s/7/3/\n" > "$PKGMAN_DEPEND_MAP_FILE"

! $PKG_CMD depends 12 | grep "3" || exit 1
$PKG_CMD depends 14 | grep "3"
$PKG_CMD depends 12 14 | grep "3"
