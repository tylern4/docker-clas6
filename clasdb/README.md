# Clasdb clone

To setup a docker container with a clone of the clasdb you will first have to connect to the clasdb from the farm.
You must have mysql-client installed on the computer you want to dump the databases onto.

In one terminal we will link the classdb to your local computer, replacing `JLAB_USERNAME` with your jlab username.
Here I'm using port `3333` but any port between `1024-49151` should work, but keep port `3306` the same as that is the port for mysql on `clasdb.jlab.org`.

```
ssh -L 3333:localhost:3333 JLAB_USERNAME@login.jlab.org -tt ssh -L 3333:clasdb.jlab.org:3306 JLAB_USERNAME@ifarm
```

Now we will dump the desired databases to sql files so we can load them into a mysql docker container.
The most generic command is, where you will replace `DATABASE_NAME` with the desired database you would like to dump.
```
mysqldump -u clasuser -h 127.0.0.1 -P 3333 --databases DATABASE_NAME > DATABASE_NAME.sql
```
I have found that for CLAS6 software I have needed `calib` and `calib_user` which can be copied with the following commands:
```
mysqldump -u clasuser -h 127.0.0.1 -P 3333 --databases calib_user > calib_user.sql
mysqldump -u clasuser -h 127.0.0.1 -P 3333 --databases calib > calib.sql
```

Now we will run a mysql server in docker and call it `clasdb` and pull the image from the standard `mysql` image with the option `-d mysql`.
Again I have chosen a random port between `1024-49151` for the docker container to use, in this case `4444`.

```
docker run --name clasdb -p 4444:3306 -e MYSQL_USER=root -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mysql
```
And check that it's up and running with:
```
docker ps
```

Now we can import the databases we have dumped with:
```
mysql -u root -h 127.0.0.1 -P 4444 < DATABASE_NAME.sql
```

Again for the `calib` and `calib_user` databases this is:
```
mysql -u root -h 127.0.0.1 -P 4444 < calib_user.sql
mysql -u root -h 127.0.0.1 -P 4444 < calib.sql
```

To commit the new databases to an image you can run later.
```
docker commit clasdb clasdb:latest
```

Now that your clasdb container is up and running you should be able to run a new CLAS6 image and link the two together by using the `--link clasdb:clasdb` option.
```
docker run --link clasdb:clasdb -v`pwd`:/root/data -it clas6:test
```

Place or replace these environment variables to the top of your scripts and your applications should be able to connect to the database.
```
CLAS_CALDB_HOST=$CLASDB_PORT_3306_TCP_ADDR
CLAS_CALDB_USER="root"
```
