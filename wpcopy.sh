#!/bin/sh
#log file for finished copies
log=logs/logwp.txt
wordpressPath="wordpress-3.4.2"
#path to sites config settings file 
sitesConfigSettingsPath=domains.txt
#destination directory - the only path that you
# have to change from hosting to hosting
path=../test
group="test"
user="user"
#END VARS DECLARATION
if [ -d "$wordpressPath" -a -f "$sitesConfigSettingsPath" ];then
    if [ ! -f "$log" ]; then
        touch "$log"
    else
        rm "$log"
        touch "$log"
    fi
    #If destination dir doesn't exist
    #mkdir "$dir"
    if [ ! -d "$path" ]; then
        mkdir "$path"
    fi
	 if [ -z "$group" ]; then
		 chgrp -R "$group" "$wordpressPath" 
	 fi
	 if [ -z "$user" ]; then
		chown -R "$user" "$wordpressPath"  
	 fi
    while read domain db_name db_user db_pass db_host
    do
         mkdir "$path"/"$domain"
         cp -rp "$wordpressPath"/. "$path"/"$domain"
         lastpath=$(pwd)
         cd  "$path"/"$domain"
         sed -e "s/database_name_here/$db_name/;s/username_here/$db_user/;s/password_here/$db_pass/;s/localhost/$db_host/" wp-config.php> /tmp/tempfile.tmp
         mv /tmp/tempfile.tmp wp-config.php
         cd "$lastpath"
         date=`date`
         echo "$domain $date">>"$log"
    done <"$sitesConfigSettingsPath"
    echo "====================================="
    cat "$log"
    wc -l "$log"
    echo "sites finished"
    echo "=============="
    echo "FINISHED"
else
        echo "Check path to wordpress zip - $wordpressPath  and path to domains list - $sitesConfigSettingsPath"
fi



