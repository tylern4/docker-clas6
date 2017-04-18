tar -xvf /mnt/calib.sql.tgz
tar -xvf /mnt/calib_user.sql.tgz
echo "Untared"
mysql -u root -h 127.0.0.1 < calib.sql
echo "calib done"
mysql -u root -h 127.0.0.1 < calib_user.sql
echo "calib_user done"
rm -rf /mnt/calib_user.sql
rm -rf /mnt/calib.sql
echo "mysql done"
