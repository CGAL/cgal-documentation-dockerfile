#!/bin/bash
set -e

if [ "$1" = 'cgal_build_documentation' ]; then
    mkdir /cgal_build
    cd /cgal_build
    cmake -DBUILD_DOC:BOOL=ON /mnt/cgal
    make doc
    make doc
else
    exec "$@"
fi
