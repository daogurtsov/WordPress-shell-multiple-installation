#!/bin/sh
#log file for settings done
log=logs/log_apache_settings.txt
#path to sites config settings file 
sitesConfigSettingsPath=domains.txt
#destination directory - the only path that you
# have to change from hosting to hosting
path=test
#apache settings file path
apache_path=C:/wamp/bin/apache/Apache2.2.21/conf/extra/httpd-vhosts.conf
ip=127.0.0.1
#END VARS DECLARATION
if [ -f "$sitesConfigSettingsPath" -a -f "$apache_path" -a -d "$path" ];then
    if [ ! -f "$log" ]; then
        touch "$log"
    else
        rm "$log"
        touch "$log"
    fi
    while read domain db_name db_user db_pass db_host
    do
	 echo "<VirtualHost $ip>" >> "$apache_path"
     echo "	DocumentRoot $path/$domain" >> "$apache_path"
     echo "	ServerName $domain" >> "$apache_path"
	 echo "</VirtualHost>" >> "$apache_path"
         date=`date`
         echo "$domain $date" >> "$log"
    done < "$sitesConfigSettingsPath"
    echo "====================================="
    cat "$log"
    wc -l "$log"
    echo "apache finished"
    echo "=============="
    echo "FINISHED"
else
        echo "Check path to wordpress zip - $wordpressPath  and path to domains list - $sitesConfigSettingsPath 
		and path to apache settings - $apache_path and check that destination path exist - $path"
fi



