#!/bin/sh
#Import list of databases to MySQL
#Start vars declaration
importPath=dbes
dbList=domains.txt
importLog=logs/import_log.txt
#End vars declaration
if [ -d "$importPath" -a -f "$dbList" ]; then
    if  [ -f "$importLog" ]; then
        rm "$importLog"
    fi
    touch "$importLog"
    while read db_file_name db_name db_user db_pass db_host
        do
            pathToDB="$importPath"/"$db_file_name"
            if [ -f "$pathToDB" ]; then
                mysql -h "$db_host" -u "$db_user" --password="$db_pass" "$db_name" < "$pathToDB"
                date=`date`
                echo "$pathToDB"
                echo "$db_file_name $date" >> "$importLog"
            else
                echo "$pathToDB"
                echo "$pathToDB -doesn't exist" >> "$importPath"
            fi
        done < "$dbList"
cat "$importLog"
echo "==============="
wc -l "$importLog"
else
    echo "Check import path and dblist file"
fi
echo "=============="
echo "IMPORT FINISHED"
