# pkgmanager -- a kiss compliant package manager

# Install
`make install`
or
`cp pkgmanager* /usr/bin`

# Dependencies
## Required
* POSIX utilities (specifically cat, comm, grep, sed, sh and su)
## Suggested
* POSIX utilities (specifically diff, tee)
* git   -- for git sources
* curl  -- for remote sources
* tar   -- for tar balls
* gzip, bzip2, xz, zstd -- to handle compressed archives
* unzip -- for zip files

# Packaging System
[Upstream kiss' packaging system](https://kisslinux.org/wiki/package-system) is basically a super set.

## Package layout

| Name    | Required | Comments/Blank lines | Format |
| ------- | -------- | -------------------- | ------ |
| build   | No\*     | N/A                  | Any executable format
| depends | No       | Yes                  | pkg [label]
| sources | No\*     | Yes                  | source [dest]
| version | Yes      | Yes                  | upstream_version repository_version

\* - Different value that upstream KISS
Note that there are less required files than upstream kiss. We don't use checksums (by default; use a hook if you want them)

### build
The build script is blindly executed so any executable is valid. When executed it is passed in `DESTDIR` `upstream_version` `repository_version`.
Example:
```
make
make DESTDIR="$1" install
```

### depends
Only direct dependencies are needed and the entire file can be omitted if no
dependencies exist. POSIX utilities can assumed to be installed and don't need
to be listed here.
Only 1 label currently has meaning. `make` is used to specify make dependencies
```
# Comment
libX11
libXrandr
# make depedency
pkgconf make
```

### sources
List of sources to be copied/cloned into the build directory. If `dest` is
specified it will be created in the build directory and that source will be put
there.
Note that if the source is archive of a single directory, the contents of that directory will be extracted.
```
# git repo denoted by the prefix 'git+'
git+https://github.com/TAAPArthur/div.git
# A local file contained in custom direcotry files in the repo
files/file
# Standard compressed tar ball
https://github.com/TAAPArthur/xsane-xrandr/archive/refs/tags/v1.2.1.tar.gz
```

### version
First word is the upstream version and the remain part of the line is this repo's version. The latter is used to indicate changes unrelated to the source files.  Only the first line of the file is read.
Note that it doesn't matter what the values are; if they differ from the installed version, the package will be considered out of date

```
1 1
```

# Configuration
The package manager can be configured via the use of environment variables.

| Name                      | Default                    | Description |
| ------------------------- | -------------------------- | ----------- |
| PKGMAN_BUILD_CACHE_DIR    | build                      | Where to store build packages relative to PKGMAN_CACHE_DIR|
| PKGMAN_CACHE_DIR          | XDG_CACHE_HOME             | Parent directory for general cache files|
| PKGMAN_DEPEND_MAP_FILE    | /var/db/pkgmanager/aliases | points to a 2-col, \t delimited file mapping dependency A to B|
| PKGMAN_DOWNLOAD_CMD       | curl                       | Used to download remote sources|
| PKGMAN_FORCE              | 0                          | Allows removable of packages even if other packages still depend on them|
| PKGMAN_HOOK_PATH          | /etc/pkgmanager/hooks.d/   | : separated list of hooks to source for key operations|
| PKGMAN_MAX_NESTED_DEPENDS | 64                         | Controls how deep the dependency tree can be for a package|
| PKGMAN_METADATA_BASE_DIR  | /var/db/pkgmanager         | Where to store metadata$PKGMAN_NAME}|
| PKGMAN_METADATA_ROOT      | PKGMAN_ROOT                | Root directory to store/read metadata|
| PKGMAN_PATH               |                            | : separated listed for each repository|
| PKGMAN_ROOT               | /                          | Root directory to install to|
| PKGMAN_SOURCE_CACHE_DIR   | sources                    | Where to store downloaded sources relative to PKGMAN_CACHE_DIR|
| PKGMAN_SOURCE_TRANSLATE   | /etc/pkgmanager/source_fix | Points to a file to convert sources when downloading remote sources; Takes pkg and version as args|
| PKGMAN_TMPDIR             | /tmp/pkgmanager/           | Temporary directory parent for installing and building|
| PKGMAN_UNPRIVILEGED_USER  | nobody                     | User to switch which trying to build when root|

# Hooks
Each hook is sourced. The `$1` will contain the type and `$2` the package. These vars are also in `$TYPE` and `$PKG` for convince.

| Hook          | PWD             |
| ------------- | --------------- |
| post-build    | DESTDIR         |
| post-install  | PKG_METADATA_DIR|
| post-remove   | PKG_METADATA_DIR|
| pre-build     | BUILD_DIR       |
| pre-remove    | PKG_METADATA_DIR|
| pre-install   | DESTDIR         |
