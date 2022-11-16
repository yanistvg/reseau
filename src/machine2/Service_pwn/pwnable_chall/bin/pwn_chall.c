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
	setbuf(stdout, NULL);
 	setbuf(stdin, NULL);
	setbuf(stderr, NULL);
	char name[1024];
	printf("Votre nom, s'il vous plait:  \n");
	fgets(name, sizeof(name), stdin);

	lo_hong(name);
 	return 0;
}
// gcc --static -fno-stack-protector -g -o pwn_chall pwn_chall.c
// gcc -m32 -mpreferred-stack-boundary=2 -fno-stack-protector -o pwn_chall -no-pie -g pwn_chall.c