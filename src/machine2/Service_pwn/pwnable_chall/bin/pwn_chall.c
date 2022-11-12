#include <stdio.h>
#include <string.h>

void lo_hong(char *str){
	char name[128];
	strcpy(name, str);
	printf("Bonjour %s\n", name);
	printf("Essayer de pwn\n");
}

int main(){
	setbuf(stdout, NULL);
	setbuf(stdin, NULL);
	setbuf(stderr, NULL);
	char name[1024];
	printf("Votre nom, s'il vous plait:  ");
	fgets(name, sizeof(name), stdin);

	lo_hong(name);
	return 0;
}
// gcc -mpreferred-stack-boundary=2 -fno-stack-protector -o vulnerable vulnerable.c
// gcc --static -fno-stack-protector -o vulnerable vulnerable.c
