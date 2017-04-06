## Parms

You're probably looking here because one of your executables failed and said it was missing a file here, there's a reason for this.
Different CLAS6 software needs different parms files to work and the parms folder on the farm is 32GB.
That's much too large to copy to a docker container or to github.
The solution is to just copy the few files you will need to use for your experiment.
Clas parm files can be found on the farm machines at either `/group/clas/parms` or `/group/clas/parms_frozen`.

After copying the files here you can either rebuild the docker container or add `-v /path/to/local/parms:/clas/parms` to the docker run command.

My suggestion is to link the docker container volumes with the `-v` at first, and test all the software you will be using.
Once you get all the parms files you will need, re-build the container so that they will always be in the newly running container.
