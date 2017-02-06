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
docker run -v "$PATH_TO_CGAL":/mnt/cgal -t cgal_doc /docker_entrypoint.sh cgal_build_documentation
#run second time to link
docker run -v "$PATH_TO_CGAL":/mnt/cgal -t cgal_doc /docker_entrypoint.sh cgal_build_documentation
#create output directories
DIR_LIST=(1_8_4 1_8_13 doxygen_master)
DOCKER_ID=$(docker ps -l -aqf "ancestor=cgal_doc")
for dir in ${DIR_LIST[*]}
do
  mkdir -p $dir
  #extract documentation to corresponding directories
  docker cp "$DOCKER_ID":/"cgal_build_$dir/doc_output" "./$dir"
  docker cp "$DOCKER_ID":"/cgal_build_$dir/doc_log" "./$dir"
  mkdir -p "$dir/testsuite_out"
  python "$PATH_TO_CGAL/Documentation/doc/scripts/testsuite.py"  --doc-log-dir "$dir/doc_log" --output-dir "$dir/doc_output" --cgal-version 1 --publish "$PWD/$dir/testsuite_out"
done
