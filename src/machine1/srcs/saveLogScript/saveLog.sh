#!/bin/bash

touch /tmp/emptyFile
echo "" > /tmp/emptyFile
diff /tmp/emptyFile /var/log/apache2/access.log > /dev/null
if [ $? = 1 ]
then
	cat /var/log/apache2/access.log > /.savelogs/$(date "+%d_%m_%y__%T_log.txt")
	echo "" > /var/log/apache2/access.log
fi
rm /tmp/emptyFile
# flag_Y_X : 4COQUINS{29Se96dubhGAfE9yypyp3sMnc}