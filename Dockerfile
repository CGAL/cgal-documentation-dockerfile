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
    mkdir cgal_1_8_13 && \
    cd cgal_dox && \
    git checkout release_1_8_13_patched && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cp bin/doxygen ../../cgal_1_8_13
    

    
RUN git clone https://github.com/doxygen/doxygen.git doxygen_1_8_18 && \
    cd doxygen_1_8_18 && \
    git checkout Release_1_8_18 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
#     cp bin/doxygen ../../1_8_18 && \
    cd ../.. && rm -rf doxygen_1_8_18

USER root

COPY ./docker_entrypoint.sh /
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["cgal_build_documentation"]
