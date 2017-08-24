FROM tylern4/rootv5:centos6
LABEL maintainer "tylern@jlab.org"

ENV MYSQLINC /usr/include/mysql
ENV MYSQLLIB /usr/lib64/mysql

RUN mkdir -p /usr/local/cernlib
COPY cernlib /usr/local/cernlib

# This is using the cernlib copied from jlab ifarm
ENV CERN /usr/local/cernlib/x86_64_rhel6
ENV CERN_LEVEL 2005
ENV CERN_ROOT $CERN/$CERN_LEVEL
ENV CVSCOSRC $CERN/$CERN_LEVEL/src
ENV PATH $CERN/$CERN_LEVEL/src:$PATH
ENV CERN_LIB $CERN_ROOT/lib
ENV CERN_BIN $CERN_ROOT/bin
ENV LD_LIBRARY_PATH $ROOTSYS/lib
ENV CLAS_PARMS /clas/parms
RUN ln -s $CERN_LIB $CERN

COPY clas-software /clas-software

ENV PATH /clas-software/build/bin:$PATH

ENV CLAS_PARMS /clas/parms
COPY parms /clas/parms
ENV PATH /clas-software/build/bin:$PATH
COPY bashrc /root/.bashrc
COPY env.sh /clas-software

#Build clas-tool
ENV CLASTOOL /clas-software/analysis/ClasTool
ENV OS_NAME Linux
RUN source /root/.bashrc \
    && cd /clas-software/analysis/ClasTool \
    && make -j$(nproc) \
    && cd Utils \
    && make

RUN cd /clas-software && scons -j$(nproc) 2> /dev/null \
    && scons install

WORKDIR /root/code

ENTRYPOINT ["/bin/bash"]
