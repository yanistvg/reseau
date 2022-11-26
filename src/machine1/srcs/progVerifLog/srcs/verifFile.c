#include "../includes/verifFile.h"

int ifFileExistsAndEmpty(char *file) {
	int fd = 0;
	char c[20];
	int n;

	fd = open(file, O_RDONLY);
	if (fd < 0)
		return 1;

	n = read(fd, c, sizeof(char)*20);
	close(fd);

	if(n < 0 || n > 1)
		return 2;

	return 0;
}

int verifBDD() {
	int fd;
	char c;

	fd = open("/tmp/tmpScript.sh", O_CREAT | O_TRUNC | O_WRONLY , 0666);
	if(fd < 0)
		return 1;
	write(fd, "#!/bin/bash\n", sizeof(char)*12);
	write(fd, "user=CTF_reseau_site\n", sizeof(char)*21);
	write(fd, "pass=q9mChiFtU4YC2568\n", sizeof(char)*22);
	write(fd, "echo \"SELECT * FROM reviews;\\nSELECT * FROM prescriptions;\\n\" | mysql CTF_reseau_site --user=$user --password=$pass > /tmp/tmp.txt\n", sizeof(char)*132);
	write(fd, "echo \"id\\temail\\treview\\tstars\\tip\\n1\\tflag_7_8\\t4COQUINS{PUfBTEdYcPU5h5ncg062wMvd}\\t5\\t0.0.0.0\" > /tmp/tmp2.txt\n", sizeof(char)*113);
	write(fd, "diff /tmp/tmp.txt /tmp/tmp2.txt > /dev/null\n", sizeof(char)*44);
	write(fd, "echo $? > /tmp/resultSql\n", sizeof(char)*25);
	write(fd, "rm /tmp/tmp.txt /tmp/tmp2.txt $0\n", sizeof(char)*33);
	close(fd);
	system("sh /tmp/tmpScript.sh");

	fd = open("/tmp/resultSql", O_RDONLY);
	if(fd < 0)
		return 1;
	read(fd, &c, sizeof(char)*1);
	close(fd);

	system("rm -rf /tmp/resultSql");

	if(c != '0')
		return 1;

	return 0;
}

int isEmptyDir(char *directory) {
	DIR *dir = NULL;
	struct dirent *dent;
	int i=0;

	dir = opendir(directory);
	if (dir != NULL)
		while ((dent=readdir(dir)) != NULL)
			if (dent->d_name[0] != '.')
				i++;

	if (dir != NULL)
		closedir(dir);

	if(i != 0 || dir==NULL)
		return 1;
	return 0;
}

int onlyOneFileInDir(char *directory, char *file) {
	DIR *dir = NULL;
	struct dirent *dent;
	int i=0, y=0;

	dir = opendir(directory);
	if (dir != NULL)
		while ((dent=readdir(dir)) != NULL) {
			if (dent->d_name[0] != '.') {
				if(strcmp(dent->d_name, file) == 0)
					y++;
				else
					i++;
			}
		}

	if (dir != NULL)
		closedir(dir);

	if(i != 0 || dir==NULL || y != 1)
		return 1;
	return 0;
}
