#!/bin/bash
set -e

if [ "$1" = 'cgal_build_documentation' ]; then
    ln -s /bin/python3 /bin/python
    if [ -d /mnt/cgal/doc/scripts ]; then
        cd /mnt/cgal/doc/scripts
    else
        cd /mnt/cgal/Documentation/doc/scripts
    fi
    mkdir -p $PWD/doc_1_8_13
    mkdir -p $PWD/doc_1_9_1
    bash -$- ./process_doc.sh "/doxygen/cgal_1_8_13/doxygen" "/doxygen/cgal_1_9_1/doxygen" /testsuite_out
else
    exec "$@"
fi
