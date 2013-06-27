ERLANG_PATH:=$(shell erl -eval 'io:format("~s~n", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS=-O3 -fPIC 
ERLANG_FLAGS=-I$(ERLANG_PATH)
CC=gcc
EBIN_DIR=ebin

ifeq ($(shell uname),Darwin)
	OPTIONS=-dynamiclib -undefined dynamic_lookup
endif

all:
	mix compile

NIF_SRC= \
	src/nif_helpers.c \
	src/exos_nif.c

clean:
	rm -f src/*.o
	rm -f share/exos_nif.so
	rm -rf $(EBIN_DIR)
	@ echo

share/exos_nif.so: ${NIF_SRC}
	$(CC) $(CFLAGS) $(ERLANG_FLAGS) -shared $(OPTIONS) -o $@ $(NIF_SRC)

.PHONY: clean

