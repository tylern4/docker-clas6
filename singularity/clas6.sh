source /mnt/env.sh
cp -r /mnt/cernlib /usr/local/cernlib
cp -r /mnt/clas-software /clas-software
mkdir -p /clas
cp -r /mnt/parms /clas/parms
cp /mnt/env.sh /clas-software/
cd /clas-software
scons -j$(nproc) 2> build.err
scons install
