#!/bin/sh
dbPath=wpdb.sql
fDomainsPath=domains.txt
logFile=logs/logdb.txt
dirName=dbes
#END DECLARATION
if [ -f "$fDomainsPath" -a -f "$dbPath" ]; then
    if [ ! -d $dirName ]; then
        mkdir  "$dirName"
        else
        counter=$(ls "$dirName" | wc -l)
            if [ "$counter" -gt 0 ]; then
                rm "$dirName"/*
            fi
    fi
    #
    if [ -f "$logFile" ]; then
        rm "$logFile"
    fi
    #
    touch "$logFile"
    while read line
        do
            db=$(echo $line | awk '{print $1}')
            echo "$db"
            cp "$dbPath" "$dirName/$db"
            sed -e "s/site.domain/$db/ig" "$dirName/$db" > /tmp/tempfile.tmp
            mv /tmp/tempfile.tmp "$dirName/$db"
            echo "$db">>"$logFile"
        done < "$fDomainsPath"
    #
    counter=`wc -l "$logFile"`
    echo "========================"
    echo "$counter dbes processed"
else
    echo "Check path to db - $dbPath and path to domains list - $fDomainsPath"
fi