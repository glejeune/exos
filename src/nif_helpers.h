#ifndef __NIF_HELPERS_H
#define __NIF_HELPERS_H

#include "erl_nif.h"

ERL_NIF_TERM mk_error(ErlNifEnv* env, const char* mesg);
ERL_NIF_TERM mk_atom(ErlNifEnv* env, const char* atom);

#endif // __NIF_HELPERS_H

