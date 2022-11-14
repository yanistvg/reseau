#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void lo_hong(char *str){
	char name[200];
	strcpy(name, str);
	printf("Bonjour %s\n", name);
	printf("Essayer de pwn\n");
}

int main(){

	char name[1024];
	printf("Votre nom, s'il vous plait:  \n");
	fgets(name, sizeof(name), stdin);

	lo_hong(name);
	return 0;
}
// gcc --static -fno-stack-protector -g -o pwn_chall pwn_chall.c