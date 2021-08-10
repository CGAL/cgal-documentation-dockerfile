#!/bin/bash
set -e
#Path to directory containing Dockerfile
PATH_TO_IMAGE="$1"
#Path to CGAL root directory
PATH_TO_CGAL="$2"
#Path to publish dir
PATH_TO_PUBLISH="$3"

# Other arguments will be arguments to docker-run
shift 3
DOCKER_RUN_EXTRA_ARGS=$@

#build docker image
docker build -t cgal_documentation:comparison $PATH_TO_IMAGE
#generate documentation
docker run $DOCKER_RUN_EXTRA_ARGS \
       -v "$PATH_TO_CGAL":/mnt/cgal:z \
       -v "$PATH_TO_PUBLISH":/testsuite_out:z \
       --entrypoint=/bin/bash \
       -t cgal_documentation:comparison \
        -$- /docker_entrypoint.sh cgal_build_documentation
