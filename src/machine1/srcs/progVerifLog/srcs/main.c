#include "../includes/include.h"

int main(void) {
	char file[40];
	char dir[40];
	int i=1;
	int isCheck = 0;

	drawWarning();

	createFilesMemory();

	while(i<=5) {
		extractFile(file, i++);
		if (ifFileExistsAndEmpty(file) != 0)
			isCheck = 1;
	}

	/* verification que seulement un fichier existe dans : /.savelogs/ : 11_11_22__15:40:01_log.txt */
	extractFile(dir, 6);
	extractFile(file, 7);
	if(onlyOneFileInDir(dir, file))
		isCheck = 1;

	/* verification dans la base de donnee */
	if (verifBDD())
		isCheck = 1;

	/* verification du dossier qui doit etre vide : /var/www/html/prescriptions/ */
	extractFile(file, 10);
	if(isEmptyDir(file))
		isCheck = 1;

	if(isCheck==0)
		drawSuccessEnd();
	else
		drawFailEnd();


	return 0;
}

/*

1  -> 27 : /var/log/apache2/access.log
2  -> 19 : /root/.bash_history
3  -> 20 : /root/.mysql_history
4  -> 26 : /home/debian/.bash_history
5  -> 24 : /var/log/apt/history.log
6  -> 11 : /.savelogs/
7  -> 26 : 11_11_22__15:40:01_log.txt
8  -> 7  : reviews
9  -> 13 : prescriptions
10 -> 28 : /var/www/html/prescriptions/
11 -> 35 : 4COQUINS{Ii8uj6SfTlI4DDPS2Asa0kMRc}
12 -> 35 : z3Vo2XlvsVPeH24oQFCu5TEOGLzrUKIlHTa

*/