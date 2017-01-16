FROM cgal/testsuite-docker:ubuntu
MAINTAINER Philipp Moeller <bootsarehax@gmail.com>
RUN  apt-get update \
  && apt-get install -y bison \
     git \
     flex-old \
     graphviz \
     python2.7 \
     python-pyquery \
     texlive-binaries \
  && apt-get clean -y \

USER makepkg
WORKDIR /tmp/makepkg

RUN git clone https://github.com/CGAL/doxygen.git cgal_master && \
    cd cgal_master && \
    ./configure && \
    make

RUN  apt-get update \
  && apt-get install -y flex \
  && apt-get clean -y 
RUN git clone https://github.com/CGAL/doxygen.git 1_8_13 \
 && cd 1_8_13 && git checkout release_1_8_13_patched && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

RUN git clone https://github.com/doxygen/doxygen.git doxygen_master && \
    cd doxygen_master && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

USER root
RUN cd /tmp/makepkg/cgal_master && make install

COPY ./docker_entrypoint.sh /
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["cgal_build_documentation"]
