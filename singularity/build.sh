#!/usr/bin/env bash
BLUE="\033[34m"
DEF="\033[0m"
MAG="\033[35m"
RED="\033[31m"
GREEN="\033[32m"

IM_PATH="."
NAME="clas6"

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -p|--path)
    IM_PATH="$2"
    shift # past argument
    ;;
    -n|--name)
    NAME="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

#Create singularity image name
IMAGE=${IM_PATH}/${NAME}.img

#If there is an image remove it
if [ -f "${IMAGE}" ]; then
    echo sudo rm -rf ${IMAGE}
fi

#Create image and build software inside it
sudo singularity create --size 3584 ${IMAGE}
sudo singularity bootstrap ${IMAGE} centos6.def
sudo singularity exec -B `pwd`:/mnt -w ${IMAGE} sh /mnt/clas6.sh
