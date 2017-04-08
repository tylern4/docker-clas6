# Build is bootstrapped from a centos6 container with root v5-34-36 installed.
# The Dockerfile to build this can be found at
# https://github.com/tylern4/docker-root/blob/master/rootv5/Dockerfile

FROM tylern4/rootv5:centos6
LABEL maintainer "tylern@jlab.org"

RUN yum install -y which mv

ENV MYSQLINC /usr/include/mysql
ENV MYSQLLIB /usr/lib64/mysql

RUN mkdir -p /usr/local/cernlib
COPY cernlib /usr/local/cernlib

# This is using the cernlib copied from jlab ifarm
# Would like to be able to build these in the container in the future.
ENV CERN /usr/local/cernlib/x86_64_rhel6
ENV CERN_LEVEL 2005
ENV CERN_ROOT $CERN/$CERN_LEVEL
ENV CVSCOSRC $CERN/$CERN_LEVEL/src
ENV PATH $CERN/$CERN_LEVEL/src:$PATH
ENV CERN_LIB $CERN_ROOT/lib
ENV CERN_BIN $CERN_ROOT/bin
ENV LD_LIBRARY_PATH $ROOTSYS/lib
RUN ln -s $CERN_LIB $CERN


COPY clas-software /clas_software

RUN cd /clas_software \
    && scons -j$(nproc) 2> clas6_build.err \
    && scons install

ENV CLAS_PARMS /clas/parms
COPY parms /clas/parms

ENV PATH /clas_software/build/bin:$PATH

ENTRYPOINT cd $ROOTSYS && source bin/thisroot.sh && cd && /bin/bash
