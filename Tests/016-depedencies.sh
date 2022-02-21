#!/bin/sh -e

for i in $(seq 1 12); do
    $PKG_CMD new "$i"
    for n in $(seq 1 "$((i-1))"); do
        if [ "$((i%n))" -eq 0 ]; then
            echo "$n" >> "$i/depends"
        fi
    done
done


# poison 7
echo "exit 2" >> 7/build

$PKG_CMD b 12

$PKG_CMD l 1 2 3 4 6

# We should use the cache for future installs
rm -rf 1 2 3 4 6
$PKG_CMD i 12

$PKG_CMD b 9 10
$PKG_CMD i 9 10
