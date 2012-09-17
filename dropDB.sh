#!/bin/sh
#Start vars declaration
dbList=domains.txt
dropLog=droplog.txt
#End vars declaration
if [ -f "$dbList" ]; then
    if  [ -f "$dropLog" ]; then
        rm "$dropLog"
    fi
    touch "$dropLog"
    while read db_file_name db_name db_user db_pass db_host
        do
                mysqldump  -h "$db_host" -u "$db_user" --password="$db_pass"   --no-data "$db_name" | grep ^DROP | mysql  -h "$db_host" -u "$db_user" --password="$db_pass" "$db_name"
                date=`date`
                echo "$db_file_name $date" >> "$dropLog"
        done < "$dbList"
cat "$dropLog"
echo "==============="
wc -l "$dropLog"
else
    echo "Check dblist file"
fi
echo "=============="
echo "DROP FINISHED"




