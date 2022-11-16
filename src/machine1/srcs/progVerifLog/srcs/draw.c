#include "../includes/draw.h"

void drawWarning() {
	printf("%s/!\\ WARNING:\n%s", YELLOW, DEFAULT_COLOR);
	printf("%s\tPour realiser cette etapes du challenge, vous avez la possibilte\n%s", YELLOW, DEFAULT_COLOR);
	printf("%s\tde recuperer ce fichier binaire pour faire du reverse ingenering\n%s", YELLOW, DEFAULT_COLOR);
	printf("%s\tmais cela n'est pas l'objectif.\n%s", YELLOW, DEFAULT_COLOR);
	printf("%s\tDes points de securite on etais ajoute pour ralentir la possibilite\n%s", YELLOW, DEFAULT_COLOR);
	printf("%s\td'effectuer le reverse. Le plus judicieux serais d'essayer de realise\n%s", YELLOW, DEFAULT_COLOR);
	printf("%s\tcette etapes normalement.\n\n%s", YELLOW, DEFAULT_COLOR);
	printf("%s\tDe plus pour faire cette partie du challenge, il vous faut penser\n%s", YELLOW, DEFAULT_COLOR);
	printf("%s\ta l'integralite des etapes qui vous on conduit ici pour pouvoir\n%s", YELLOW, DEFAULT_COLOR);
	printf("%s\teffacer ces trace methodiquement.\n\n%s", YELLOW, DEFAULT_COLOR);
}

void drawSuccessEnd() {
	char flag[40];

	extractFlag(flag);
	printf("%sFelicitation, vous avez reussie a effacer les traces necessaire :%s\n", GREEN, DEFAULT_COLOR);
	printf("%s\t%s%s\n", GREEN, flag, DEFAULT_COLOR);
}

void drawFailEnd() {
	printf("%sNous sommes au regret de vous annoncer que vous n'avais pas reussie%s\n", RED, DEFAULT_COLOR);
	printf("%sa effacer vos traces que ce programme verifie.%s\n\n", RED, DEFAULT_COLOR);
	printf("%sPour rappel, il est important de ce rappeler des etapes que vous avez realise%s\n", CYAN, DEFAULT_COLOR);
	printf("%spour arriver a cette etapes pour pouvoir supprimer vos traces%s\n", CYAN, DEFAULT_COLOR);
}