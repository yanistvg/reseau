#!/bin/bash
#
## script de mise en place d'une machine dans le cadre d'un projet
## de realisation d'un CTF. Ce scipt a etais realise pour un machine
## debian-10.
#
# Cette variable est presente pour choisir une deux deux machine a installer
#  : 1 -> installer la premiere machine
#  : 2 -> installer la seconde machine
num_machine="1"
# Variables de couleur pour l'affichage
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
## create_file_sshKey_for_github permet de creer le fichier qui contient
## une clef priver pour pouvoir cloner le repos git
##
## localisation file : /tmp/id_rsa
##
create_file_sshKey_for_github() {
	touch /tmp/id_rsa
	if [ $? != 0 ]
	then
		echo "[$cl_red-$cl_df] Fail to create id_rsa file"
	else
		echo "-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----" > /tmp/id_rsa
		if [ $? != 0 ]
		then
			echo "[$cl_red-$cl_df] Fail to write in file /tmp/id_rsa"
		else
			chmod 600 /tmp/id_rsa
			echo "[$cl_green+$cl_df] /tmp/id_rsa was created"
		fi
	fi
}
##
## clone_repos_from_github permet de cloner le repos git du projet dans 
## /tmp pour pouvoir recuperer des fichiers qui serviront a la configuration
## de la machine comme un site internet
##
clone_repos_from_github() {
	create_file_sshKey_for_github
	if [ ! -e /tmp/id_rsa ]
	then
		echo "[$cl_red-$cl_green] Without file /tmp/id_rsa we cannot clone git repos"
	else
		GIT_SSH_COMMAND='ssh -i /tmp/id_rsa -o StrictHostKeyChecking=no' git clone git@github.com:yanistvg/reseau.git "/tmp/reseau" -q > /dev/null
		if [ $? != 0 ]
		then
			echo "[$cl_red-$cl_df] Fail to clone the git repos"
		else
			echo "[$cl_green+$cl_df] The git repos was clone with successful"
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
echo "$cl_blue Installation de la machine $num_machine$cl_df"
install_package "git"
clone_repos_from_github
sh "/tmp/reseau/src/machine$num_machine/install.sh" # lancement du script de la machine choisie
delete_package "git"
echo "" > /root/.ssh/known_hosts # oublier la connection git
delete_file_or_directory "/tmp/id_rsa" # suppresion de la clef RSA
delete_file_or_directory "/tmp/reseau" # suppresion du repos du git
delete_file_or_directory "$0"
