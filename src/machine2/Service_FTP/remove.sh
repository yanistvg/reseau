delete_package() {
	if [ $# != 1 ]
	then
		echo "[$cl_red-$cl_df] You need to give one argument for : $cl_purple delete_package$cl_df"
	else
		which $1 > /dev/null
		if [ $? != 0 ]
		then
			echo "[$cl_red-$cl_df] Package $cl_cyan$1$cl_df do not exist"
		else
			echo "[$cl_green+$cl_df] Starting the deletion of :$cl_cyan $1 $cl_df"
			apt-get remove -y $1 > /dev/null
			if [ $? != 0 ]
			then
				echo "[$cl_red-$cl_df] $cl_cyan$1$cl_df : Deletion failed"
			else
				apt-get autoremove -y > /dev/null
				echo "[$cl_green+$cl_df] Successful deletion of $cl_cyan$1$cl_df"
			fi
		fi
	fi
}


delete_package "vsftpd"
deluser --remove-home sshuser
deluser --remove-home ftpuser
rm /etc/vsftpd.conf.orig /etc/vsftpd.conf  /etc/vsftpd.userlist 
