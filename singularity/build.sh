sudo rm -rf /mnt/Data/clas6.img
sudo singularity create --size 7168 /mnt/Data/clas6.img
sudo singularity bootstrap /mnt/Data/clas6.img centos6.def
sudo singularity exec -B `pwd`:/mnt -w /mnt/Data/clas6.img sh /mnt/mysql.sh
sudo singularity exec -B `pwd`:/mnt -w /mnt/Data/clas6.img "mysql < /mnt/user_setup.sql"
sudo singularity exec -B `pwd`:/mnt -w /mnt/Data/clas6.img sh /mnt/clas6.sh
