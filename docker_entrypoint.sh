#!/bin/bash
set -e

if [ "$1" = 'cgal_build_documentation' ]; then
    cd /mnt/cgal/Documentation/doc/scripts/
    mkdir -p $PWD/testsuite_out
    mkdir -p $PWD/doc_1_8_4 
    mkdir -p $PWD/doc_1_8_13
    bash ./process_doc.sh "/doxygen/cgal_1_8_4/doxygen" "/doxygen/cgal_1_8_13/doxygen" $PWD/testsuite_out
else
    exec "$@"
fi
