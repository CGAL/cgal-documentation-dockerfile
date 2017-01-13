#!/bin/bash
set -e

if [ "$1" = 'cgal_build_documentation' ]; then
    mkdir -p /cgal_build_master
    mkdir -p /cgal_build_1_8_13
    mkdir -p /cgal_build_doxygen_master
    cd /cgal_build_master
    cmake -DBUILD_DOC:BOOL=ON \
          -DCGAL_DOC_CREATE_LOGS:BOOL=ON \
          /mnt/cgal
    make doc
    make Documentation_test
    cd ../cgal_build_1_8_13
    cmake -DBUILD_DOC:BOOL=ON \
          -DCGAL_DOC_CREATE_LOGS:BOOL=ON \
          -DDOXYGEN_EXECUTABLE:FILEPATH='/tmp/makepkg/1_8_13/build/bin/doxygen' \
          /mnt/cgal
    make doc
    make Documentation_test
    cd ../cgal_build_doxygen_master
    cmake -DBUILD_DOC:BOOL=ON \
          -DCGAL_DOC_CREATE_LOGS:BOOL=ON \
          -DDOXYGEN_EXECUTABLE:FILEPATH='/tmp/makepkg/doxygen_master/build/bin/doxygen' \
          /mnt/cgal
    make doc
    make Documentation_test

else
    exec "$@"
fi
