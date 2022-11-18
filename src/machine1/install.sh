#!/bin/bash

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

echo "$cl_blue Debut du script d'installation de la premiere machine$cl_df"

root_pass="aMialox4fmEX8gxaw37oNCNe"
debian_pass="QerwjkH6DEDAPMFM7wpD"

# Installation des packets pour le challenge
install_package "apache2"
install_package "php"
install_package "mariadb-server"
install_package "php-mysqli"
install_package "python"
install_package "cron"
install_package "gcc"
install_package "make"

#
## Mise en place du site web pour la premier faille
#
echo "CREATE DATABASE CTF_reseau_site;\nUSE CTF_reseau_site;\nCREATE USER 'CTF_reseau_site'@localhost IDENTIFIED BY 'q9mChiFtU4YC2568';\nGRANT ALL PRIVILEGES ON *.* TO 'CTF_reseau_site'@localhost IDENTIFIED BY 'q9mChiFtU4YC2568';\nexit\n" | mysql -u root
mysql CTF_reseau_site -u root < /tmp/reseau/src/machine1/srcs/bddSite/bdd.sql
rm -rf /var/www/html/*
cp -r /tmp/reseau/src/machine1/srcs/webSite/* /var/www/html/
mkdir /var/www/html/prescriptions/
chown nobody /var/www/html/prescriptions/
chmod 777 /var/www/html/prescriptions/

#
## Mise en place de l'elevation de privillege pour passer de l'utilisateur:
## www-data -> debian -> root
#
# install -m =xs $(which python) /home/debian/
echo "En cas de problème :\ndebian:QerwjkH6DEDAPMFM7wpD" > /var/www/rescuse.txt
chmod 700 /home/debian/
echo "$root_pass\n$root_pass\n" | passwd root 			# changer le mot de passe de root
echo "$debian_pass\n$debian_pass\n" | passwd debian 	# changer le mot de passe de debian
echo "$root_pass\n" | groupmems -d debian -g sudo		# retirer debian des sudoer

# echo "\n\n\n" | ssh-keygen -b 4096
# cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
# cp /root/.ssh/id_rsa /tmp/id_rsa_sshkey_root
# rm -rf /root/.ssh/id_rsa /root/.ssh/id_rsa.pub
# chmod 600 /root/.ssh/authorized_keys
chmod +s $(which cp)
# sed -i "5s/blablabla/" file

#
## Mise en place des sauvegardes des logs
#
mkdir /.savelogs/													# dossier contenant les sauvegardes des logs apache
echo "log keeper" > /.savelogs/11_11_22__15:40:01_log.txt			# fausse sauvegarde de log
echo "log keeper" > /root/11_11_22__15:40:01_log.txt				# en cas de suppresion de la fausse log
echo "" > /var/log/apache2/access.log 								# mise a zero des logs apaches
echo "\n*/1 * * * * root /etc/cron.d/saveLog.sh" >> /etc/crontab	# ajoue d'un cron
cp /tmp/reseau/src/machine1/srcs/saveLogScript/saveLog.sh /etc/cron.d/
chmod +x /etc/cron.d/saveLog.sh

#
## Mise en place des verification des trace pour le dernier flag
#
make -C /tmp/reseau/src/machine1/srcs/progVerifLog/
cp /tmp/reseau/src/machine1/srcs/progVerifLog/traceCheck /bin/

#
## Mise en place des flags sur la machine
#
echo "4COQUINS{pRv0Err2ze03MR57pX9L1gdrC}" > /var/www/flag_1_X.txt
echo "4COQUINS{wZ2G8NQ0Wl7MAbysWu4Jw46kp}" > /home/debian/flag_2_X.txt
echo "4COQUINS{MUmjobP5q6w2bDA5xnon6DD89}" > /root/flag_3_X.txt

# flag dans la base de donne   : flag_Y_X : 4COQUINS{PUfBTEdYcPU5h5ncg062wMvd}
# flag dans le fichier saveLog : flag_Y_X : 4COQUINS{29Se96dubhGAfE9yypyp3sMnc}

# lancement des services
/etc/init.d/apache2 restart
/etc/init.d/cron restart
/etc/init.d/ssh restart

delete_package "make"
delete_package "gcc"

cat /dev/null > /var/log/apache2/access.log
cat /dev/null > /root/.bash_history
cat /dev/null > /root/.mysql_history
cat /dev/null > /home/debian/.bash_history










