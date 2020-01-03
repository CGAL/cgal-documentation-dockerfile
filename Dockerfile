FROM cgal/testsuite-docker:ubuntu
MAINTAINER Philipp Moeller <bootsarehax@gmail.com>
RUN  apt-get update \
  && apt-get install -y bison \
     git \
     flex-old \
     graphviz \
     python3.5 \
     python-pyquery \
     texlive-binaries \
  && apt-get clean -y \
RUN mkdir /doxygen
WORKDIR /doxygen

RUN git clone https://github.com/CGAL/doxygen.git cgal_dox && \
    mkdir cgal_1_8_4 cgal_1_8_13 && \
    cd cgal_dox && \
    git checkout release_1_8_4_patched && \
    ./configure && \
    make && \
    cp bin/doxygen ../cgal_1_8_4 && \
    rm VERSION && \
    git clean -f -X -d

RUN  apt-get update \
  && apt-get install -y flex \
  && apt-get clean -y 
RUN cd cgal_dox && git checkout release_1_8_13_patched && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cp bin/doxygen ../../cgal_1_8_13 && \
    cd ../.. && rm -rf ./cgal_dox


#RUN git clone https://github.com/doxygen/doxygen.git doxygen_master && \
#    cd doxygen_master && \
#    mkdir build && \
#    cd build && \
#    cmake .. && \
#    make && \
#    cp bin/doxygen ../../master && \
#    cd ../.. && rm -rf doxygen_master

USER root

COPY ./docker_entrypoint.sh /
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["cgal_build_documentation"]
