#ifndef __COLOR_H__
#define __COLOR_H__

#ifndef BG_LIGHT

#define BLACK    "\033[1;30m"
#define RED      "\033[1;31m"
#define GREEN    "\033[1;32m"
#define YELLOW   "\033[1;33m"
#define BLUE     "\033[1;34m"
#define PURPLE   "\033[1;35m"
#define CYAN     "\033[1;36m"
#define GREY     "\033[1;37m"

#else // else BG_LIGHT

#define BLACK    "\033[0;30m"
#define RED      "\033[0;31m"
#define GREEN    "\033[0;32m"
#define YELLOW   "\033[0;33m"
#define BLUE     "\033[0;34m"
#define PURPLE   "\033[0;35m"
#define CYAN     "\033[0;36m"
#define GREY     "\033[0;37m"

#endif // endif BG_LIGHT

#define DEFAULT_COLOR "\033[0;m"
#define OK  BLUE "[" GREEN  "ok" BLUE "] " DEFAULT_COLOR

#endif