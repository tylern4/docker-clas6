## Building clas6 software

These instructions cover building CLAS6 software from the clas6 folder.

## Installing
First download the CLAS6 software to `clas-software`.
```
svn co https://jlabsvn.jlab.org/svnroot/clas/trunk/ clas-software
```
You can modify or add anything you would like to `clas-software` before you build the container.
After the software is checked out, you can build the container with:
```
docker build -t clas6:test .
```
It is also possible to modify the `clas-software` and then rebuild the container by just re-running the above command.

To run the built container:
```
docker run -v`pwd`:/root/data -it clas6:test
```
Which will give you a bash shell with all the CLAS6 executables in the path.
It will also give you access to your current working directory.
This should be used for input and output of files.
