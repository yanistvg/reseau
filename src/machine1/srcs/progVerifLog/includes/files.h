#ifndef __FILES_H_
#define __FILES_H_

long int nb_char_1;
long int nb_char_2;
char files[420];

void createFilesMemory();
void extractFile(char *file, int numFile);
int  extractNumCharFile(int numFile);
void extractFlag(char *flag);

#endif