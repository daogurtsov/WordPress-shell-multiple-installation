#!/bin/sh
#Start vars declaration
dbList=domains.txt
createLog=logs/create_log.txt
rootUser="root"
rootPass="win7"
#on some vds set user@"%"
rootHost="localhost"
#End vars declaration
if [ -f "$dbList" ]; then
    if  [ -f "$createLog" ]; then
        rm "$createLog"
    fi
    touch "$createLog"
    while read db_file_name db_name db_user db_pass db_host
        do
                query="CREATE USER '$db_user'@'$rootHost' IDENTIFIED BY '$db_pass'"
                mysql -u "$rootUser" --password="$rootPass" -h "$rootHost" -e "$query"
                query="CREATE DATABASE $db_name CHARACTER SET utf8 COLLATE utf8_bin"
                mysql -u "$rootUser" --password="$rootPass" -h "$rootHost" -e "$query"
                query="GRANT ALL PRIVILEGES ON $db_name.* TO $db_user@$rootHost"
                mysql -u "$rootUser" --password="$rootPass" -h "$rootHost" -e "$query"
                date=`date`
                echo "$db_file_name $date" >> "$createLog"
        done < "$dbList"
cat "$createLog"
echo "==============="
wc -l "$createLog"
fi
echo "=============="
echo "CREATION FINISHED"
echo "=============="
