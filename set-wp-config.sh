#!/bin/sh
#log file for finished copies
log=logs/set-wp-config-log.txt
wordpressFileName=wordpress-3.4.2
wordpressPath="$wordpressFileName"
#path to sites config settings file
sitesConfigSettingsPath=domains.txt
#destination directory - the only path that you
# have to change from hosting to hosting
path=/home
innerFolderDestenationPath=public_html
#END VARS DECLARATION
if [ -d "$wordpressPath" -a -f "$sitesConfigSettingsPath" ];then
    if [ ! -f "$log" ]; then
        touch "$log"
    else
        rm "$log"
        touch "$log"
    fi
    while read domain db_name db_user db_pass db_host
    do
         lastpath=$(pwd)
         cd  "$path/$domain/$innerFolderDestenationPath"
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




