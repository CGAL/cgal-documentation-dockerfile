#!/bin/bash
set -e

if [ "$1" = 'cgal_build_documentation' ]; then
    ln -s /bin/python3 /bin/python
    cd /mnt/cgal/doc/scripts/
    mkdir -p $PWD/doc_1_8_13
    mkdir -p $PWD/doc_1_9_1
    bash -$- ./process_doc.sh "/doxygen/cgal_1_8_13/doxygen" "/doxygen/cgal_1_9_1/doxygen" /testsuite_out
else
    exec "$@"
fi
