CFLAGS=-Wall -O0
EXEC=tp0
CC=gcc
SRC=$(wildcard *.c)
OBJS=$(SRC:.c=.o)
LDFLAGS=

all: clean $(EXEC)

%.o: %.c
	$(CC) $(CFLAGS) -c $<

$(EXEC): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(EXEC)

clean:
	rm -f *.o $(EXEC)

