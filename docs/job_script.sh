#!/bin/sh
# The prefix points to the singularty instalilation of the clas6 software
export PREFIX=/clas-software

# Enviromnets copied from clas enviromnet scripts
# May be redundant with enviromnet already established in singularty container
export ROOT=/usr/local/root
export CERN=/apps/cernlib/x86_64_rhel6_4.7.2/2005

PATH=.:$PREFIX/build/bin
PATH=$PATH:$PREFIX/scripts
PATH=$PATH:$ROOT/bin
PATH=$PATH:/site/bin:/apps/bin
PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin
PATH=$PATH:./bin:./build/bin
export PATH

LD_LIBRARY_PATH=.:$PREFIX/build/lib
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOT/lib
export LD_LIBRARY_PATH
export MYSQLINC=/usr/include/mysql
export MYSQLLIB=/usr/lib64/mysql

export CERNLIB=$CERN/lib
export CLAS6INC=$PREFIX/build/include
export CLAS6LIB=$PREFIX/build/lib
export CLAS6BIN=$PREFIX/build/bin
export CLAS_PARMS=/group/clas/parms

# An example of running a generator
# then gsim_bat
# gpp (gsim post processing)
# And then user_ana (reconstruction)
aao_rad < aao_rad.inp
gsim_bat -nomcdata -ffread gsim.inp -mcin aao_rad.evt -kine 1 -bosout gsim.bos
gpp -ouncooked.bos -a2.35 -b2.35 -c2.35 -f0.97 -P0x1b -R36557 gsim.bos
user_ana -t user_ana.tcl
