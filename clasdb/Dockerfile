FROM mysql:latest
LABEL maintainer "tylern@jlab.org"

ADD calib.sql.gz /docker-entrypoint-initdb.d/
ADD calib_user.sql.gz /docker-entrypoint-initdb.d/

RUN cd /docker-entrypoint-initdb.d/ \
    && gunzip calib.sql.gz \
    && gunzip calib_user.sql.gz

EXPOSE 3306 33060
CMD ["mysqld"]

