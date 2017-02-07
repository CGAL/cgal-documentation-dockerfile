#!/bin/bash
set -e

if [ "$1" = 'cgal_build_documentation' ]; then
    mkdir -p /cgal_build_1_8_4
    mkdir -p /cgal_build_1_8_13
    mkdir -p /cgal_build_doxygen_master
    cd /cgal_build_1_8_4
    cmake -DCGAL_DOC_CREATE_LOGS:BOOL=ON \
          /mnt/cgal/Documentation/doc
    make doc
    make doc
    make Documentation_test
    python "/mnt/cgal/Documentation/doc/scripts/testsuite.py"  --doc-log-dir "./doc_log" --output-dir "./doc_output" --cgal-version 1 --publish "/testsuite_out/1_8_4"
cd /doxygen
ls
    cd /cgal_build_1_8_13
    cmake -DCGAL_DOC_CREATE_LOGS:BOOL=ON \
          -DDOXYGEN_EXECUTABLE:FILEPATH='/doxygen/1_8_13/build/bin/doxygen' \
          /mnt/cgal/Documentation/doc
    make doc
    make doc
    make Documentation_test
    python "/mnt/cgal/Documentation/doc/scripts/testsuite.py"  --doc-log-dir "./doc_log" --output-dir "./doc_output" --cgal-version 1 --publish "/testsuite_out/1_8_13"
    cd ../cgal_build_doxygen_master
    cmake -DCGAL_DOC_CREATE_LOGS:BOOL=ON \
          -DDOXYGEN_EXECUTABLE:FILEPATH='/doxygen/doxygen_master/build/bin/doxygen' \
          /mnt/cgal/Documentation/doc
    
    make doc
    make doc
    make Documentation_test
    python "/mnt/cgal/Documentation/doc/scripts/testsuite.py"  --doc-log-dir "./doc_log" --output-dir "./doc_output" --cgal-version 1 --publish "/testsuite_out/doxygen_master"
else
    exec "$@"
fi
