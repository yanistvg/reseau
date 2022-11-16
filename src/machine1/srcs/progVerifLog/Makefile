CC = gcc
CFLAGS = -g -w -Wall

NAME = traceCheck

OBJS = main.o      \
       files.o     \
       verifFile.o \
       draw.o

all: $(OBJS)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS)

clean:
	rm -f $(NAME) $(OBJS)

main.o: srcs/main.c includes/include.h
	$(CC) $(CFLAGS) -c srcs/main.c
files.o: srcs/files.c includes/files.h
	$(CC) $(CFLAGS) -c srcs/files.c
verifFile.o: srcs/verifFile.c includes/verifFile.h
	$(CC) $(CFLAGS) -c srcs/verifFile.c
draw.o: srcs/draw.c includes/draw.h
	$(CC) $(CFLAGS) -c srcs/draw.c