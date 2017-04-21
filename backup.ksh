##this script canbe set as cron job to eexecute daily as follow
##30 20 * * * /bin/bash ~/backup.ksh
mkdir ~/backup
cd ~/backup

backup_dir=backup_`date +%Y%m%d`

##deleting 6 days old backup folders
find . -type d -name backup* -mtime +6 | xargs rm -rf
##taking backup now date wise

if [ ! -d $backup_dir ]
then
mkdir $backup_dir
fi

cp -r /var/lib/mysql ~/backup/$backup_dir
if [ `echo $?` -eq 0 ]
then

echo "backup was successful"
else
echo "backup failed"
fi
