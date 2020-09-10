#!/bin/bash
set -e

if [ "$1" = 'cgal_build_documentation' ]; then
    ln -s /bin/python3 /bin/python
    cd /mnt/cgal/Documentation/doc/scripts/
    mkdir -p $PWD/testsuite_out
    mkdir -p $PWD/doc_1_8_14 
    mkdir -p $PWD/doc_1_8_18
    bash ./process_doc.sh "/doxygen/cgal_1_8_13/doxygen" "/doxygen/1_8_18/doxygen" $PWD/testsuite_out
else
    exec "$@"
fi
