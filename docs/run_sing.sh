#!/bin/bash
export PATH=/usr/bin:$PATH

singularity exec \
-B /lustre:/lustre \
-B /lustre/expphy/cache:/cache \
-B /lustre/expphy/volatile:/volatile \
-B /u/group:/group \
-B /w/work:/work \
-B /u/home:/home \
/path/to/singularty.img /home/user/path/to/job_script.sh
