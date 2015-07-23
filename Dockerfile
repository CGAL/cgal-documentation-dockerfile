FROM cgal/testsuite-docker:archlinux
MAINTAINER Philipp Moeller <bootsarehax@gmail.com>

RUN pacman -Syy && pacman -S --noconfirm \
    bison \
    flex \
    git \
    graphviz \
    python2 \
    python2-pyquery \
    && \
    pacman -Scc --noconfirm

USER makepkg
WORKDIR /tmp/makepkg
RUN git clone https://github.com/CGAL/doxygen.git && \
    cd doxygen && ./configure && \
    make && make install
USER root

COPY ./docker_entrypoint.sh /
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["cgal_build_documentation"]
