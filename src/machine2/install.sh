#!/bin/bash

#
## script de mise en place d'une machine dans le cadre d'un projet
## de realisation d'un CTF. Ce scipt a etais realise pour un machine
## debian-10.
#

cl_black="\033[1;30m"
cl_red="\033[1;31m"
cl_green="\033[1;32m"
cl_yellow="\033[1;33m"
cl_blue="\033[1;34m"
cl_purple="\033[1;35m"
cl_cyan="\033[1;36m"
cl_grey="\033[1;37m"
cl_df="\033[0;m"

##
## install_package allows you to install a package. This function
## requires an argument which is the name of the package to install
##
## ex : install_package "apache2"
##
install_package() {
	if [ $# != 1 ]
	then
		echo "[$cl_red-$cl_df] You need to give one argument for : $cl_purple install_package$cl_df"
	else
		which $1 > /dev/null
		if [ $? = 0 ]
		then
			echo "[$cl_green+$cl_df] Package $cl_cyan$1$cl_df already exists"
		else
			echo "[$cl_green+$cl_df] Starting the installation of :$cl_cyan $1 $cl_df"
			apt-get install -y $1 > /dev/null
			if [ $? = 0 ]
			then
				echo "[$cl_green+$cl_df] Successful installation of $cl_cyan$1$cl_df"
			else
				echo "[$cl_red-$cl_df] $cl_cyan$1$cl_df : Installation failed"
			fi
		fi
	fi
}

##
## delete_package allows you to remove packages. This function
## requires an argument which is the name of the package to delete
##
## ex : delete_package "nano"
##
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

##
## delete_file_or_directory permet de supprimer un ficher ou un dossier si il
## existe cette fonction prend un argument qui est le nom du fichier
##
## ex : delete_file_or_directory "/tmp/test"
##
delete_file_or_directory() {
	if [ $# != 1 ]
	then
		echo "[$cl_red-$cl_df] You need to give one argument for : $cl_purple delete_file_or_directory$cl_df"
	else
		if [ ! -e $1 ]
		then
			echo "[$cl_red-$cl_df] $cl_cyan$1$cl_df: Do not exist"
		else
			rm -rf $1 > /dev/null
			if [ $? != 0 ]
			then
				echo "[$cl_red-$cl_green] Fail to delete file or directory: $cl_cyan$1$cl_df"
			else
				echo "[$cl_green+$cl_df] $cl_cyan$1$cl_df was delete with success"
			fi
		fi
	fi
}


echo "$cl_blue Debut du script d'installation de la seconde machine$cl_df"

echo -en "o&cb^26fObHr#deB5c&\no&cb^26fObHr#deB5c&\n" | passwd

## echo -en "PwnAb4l#User1&3\nPwnAb4l#User1&3\n\n\n\n\n\n\nY\n" |  adduser ctf

## ssh config

# adduser sshuser
# echo -en "ZassW0rdfoRssh#\nZassW0rdfoRssh#\n" | passwd sshuser
echo -en "ZassW0rdfoRssh#\nZassW0rdfoRssh#\n\n\n\n\n\n\nY\n" |  adduser sshuser

# useradd -m -p $1$xVZR4OBt$LGGJdSf6xHadymo6fuoWs1 sshuser
install_package "openssh-server"


## ftp config

install_package "vsftpd"

# adduser ftp
# echo -en "p@ssftp1#1\np@ssftp1#1\n" | passwd ftp 
echo -en "sunflowerseed\nsunflowerseed\n\n\n\n\n\n\nY\n" |  adduser ftp
mkdir /home/ftp/ftp
chown nobody:nogroup /home/ftp/ftp
chmod a-w /home/ftp/ftp
mkdir /home/ftp/ftp/files
chown ftp:ftp /home/ftp/ftp/files
cp /tmp/reseau/src/machine2/Service_pwn/pwnable_chall/bin/executable.zip  /home/ftp/ftp/files

cp /etc/vsftpd.conf /etc/vsftpd.conf.orig
cat Service_FTP/vsftpd.conf > /etc/vsftpd.conf
sed -i 's,\r,,;s, *$,,' /etc/vsftpd.conf
# rm /etc/vsftpd.conf


echo "ftp" | tee -a /etc/vsftpd.userlist


systemctl restart vsftpd
systemctl enable vsftpd


/tmp/reseau/src/machine2/Service_pwn/pwnable_chall/




## setup finger
install_package "finger"
install_package "fingerd"
install_package "inetutils-inetd"
echo "cat /etc/inetd.conf"
echo "finger    stream    tcp    nowait        nobody    /usr/sbin/tcpd    /usr/sbin/in.fingerd" | tee -a /etc/inetd.conf
echo "finger    stream    tcp4    nowait        nobody    /usr/sbin/tcpd    /usr/sbin/in.fingerd" | tee -a /etc/inetd.conf
echo "finger    stream    tcp6    nowait        nobody    /usr/sbin/tcpd    /usr/sbin/in.fingerd" | tee -a /etc/inetd.conf

/etc/init.d/inetutils-inetd restart


## setup cron
install_package "cron"
echo "\n*/1 * * * * root /opt/clean.sh" >> /etc/crontab
cp /tmp/reseau/src/machine2/clean.sh /opt/
chmod +x /opt/clean.sh



## run server pwnable
sed -i -e 's/\r$//' /tmp/reseau/src/machine2/Service_pwn/pwnable_chall/install_pwnserver.sh
chmod +x /tmp/reseau/src/machine2/Service_pwn/pwnable_chall/install_pwnserver.sh
/tmp/reseau/src/machine2/Service_pwn/pwnable_chall/install_pwnserver.sh


## sed -i -e 's/\r$//' install.sh