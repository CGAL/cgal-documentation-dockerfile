#!/bin/bash
set -e
#Must be called from the wanted output directory

#Path to directory containing Dockerfile
PATH_TO_IMAGE="$1"
#Path to CGAL root directory
PATH_TO_CGAL="$2"

#build docker image
docker build -t cgal_doc $PATH_TO_IMAGE
#generate documentation
mkdir -p "$PWD/results"
cd ./results
mkdir -p 1_8_4
mkdir -p 1_8_13
mkdir -p doxygen_master
cd ..

docker run -v "$PATH_TO_CGAL":/mnt/cgal -v "$PWD/results":/testsuite_out -t cgal_doc /docker_entrypoint.sh cgal_build_documentation
