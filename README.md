cgal-doxygen-image
==================

This Docker image can be used to build the documentation of CGAL.

It requires a single user mounted volume containing the CGAL tree to be used, `/mnt/cgal`.

Example Usage:

    # Build or pull the image
    docker build -t cgal-doxygen .
    docker run -v /path/to/cgal:/mnt/cgal -t -i \
               cgal-doxygen /bin/bash /docker_entrypoint.sh cgal_build_documentation

    # Extract the created documentation
    docker cp container_id:/[cgal_build_1_8_13 or cgal_build_doxygen_master or cgal_build_master]/doc_output /tmp/doc_output
    # Extract the documentation testsuite
    docker cp container_id:/[cgal_build_1_8_13/doc_output or cgal_build_doxygen_master or cgal_build_master]/doc_log /tmp/doc_log
