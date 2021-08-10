cgal-doxygen-image
==================

This Docker image can be used to build the documentation of CGAL.

It requires a single user mounted volume containing the CGAL tree to be used, `/mnt/cgal`.

Example Usage:

    #call the script 
    `./generate_documentation.sh <path_to_image> <path_to_cgal> <path_to_publish_dir>`
    where 
    - `path_to_image` is the absolute path to the directory containing the dockerfile
    - `path_to_cgal` is the absolute path to either:
      - the root directory of a CGAL release tarball, or
      - the `Documentation` directory of a CGAL Git repository.
    - `path_to_publish_dir` is the absolute path to the output directory, that will contain the 3 versions and the result of the comparison. 
