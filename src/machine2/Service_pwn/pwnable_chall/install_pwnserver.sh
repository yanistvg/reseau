#!/bin/bash

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

# echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt update -y
# apt install apt-transport-https ca-certificates -y curl gnupg2 software-properties-common
install_package "apt-transport-https"
install_package "ca-certificates"
curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update -y
apt-cache policy docker-ce
# apt install docker-ce -y
install_package "docker-ce"

# install_package "gcc"

sudo bash -c 'echo 0 > /proc/sys/kernel/randomize_va_space'
# gcc --static -fno-stack-protector /bin/pwnable_chall.c -o /bin/pwnable_chall
## Buffer Overflow Using Return to Libc
## gcc --static -fno-stack-protector /bin/pwnable_chall.c -o /bin/pwnable_chall
docker build -t pwnable_chall .
docker run -d -p 3000:9999 pwnable_chall:latest
