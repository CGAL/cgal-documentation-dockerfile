#!/bin/bash
set -e

if [ "$1" = 'cgal_build_documentation' ]; then
    cd /mnt/cgal/Documentation/doc/scripts/
    bash ./process_doc.sh "/doxygen/cgal_1_8_4/doxygen" "/doxygen/cgal_1_8_13/doxygen" /testsuite_out
else
    exec "$@"
fi
