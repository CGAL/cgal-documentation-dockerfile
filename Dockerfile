FROM cgal/testsuite-docker:ubuntu
MAINTAINER Philipp Moeller <bootsarehax@gmail.com>
RUN  apt-get update \
  && apt-get install -y bison \
     git \
     flex \
     graphviz \
     python3 \
     python3-pyquery \
     texlive-binaries \
  && apt-get clean -y 
  
RUN mkdir /doxygen
WORKDIR /doxygen

RUN git clone https://github.com/CGAL/doxygen.git cgal_dox && \
    mkdir cgal_1_8_14 cgal_1_8_13 && \
    cd cgal_dox && \
    git checkout release_1_8_14_patched && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cp bin/doxygen ../../cgal_1_8_14
    
RUN cd cgal_dox && git checkout release_1_8_13_patched && \
    cd build && \
    rm -rf ./* && \
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
