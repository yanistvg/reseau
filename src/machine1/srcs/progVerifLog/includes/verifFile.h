#ifndef __VERIFFILE_H_
#define __VERIFFILE_H_

#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <dirent.h>
#include <string.h>

int ifFileExistsAndEmpty(char *file);
int verifBDD();
int isEmptyDir(char *directory);
int onlyOneFileInDir(char *directory, char *file);

#endif