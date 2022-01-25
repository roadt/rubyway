
VERSION=ruby-$(ruby -v |cut -d' ' -f2 |cut -d. -f1-2)  # ruby-1.9 , ruby-2.2 etc..

CFLAGS=$(shell  pkg-config --cflags $VERSION)
LDFLAGS=$(shell pkg-config --libs $VERSION)


BINS=$(patsubst %.c, %, $(wildcard *.c))


all : $(BINS)
	echo $(BINS)


