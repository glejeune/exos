#include "nif_helpers.h"

ERL_NIF_TERM mk_atom(ErlNifEnv* env, const char* atom) {
  ERL_NIF_TERM ret;

  if(!enif_make_existing_atom(env, atom, &ret, ERL_NIF_LATIN1)) {
    return enif_make_atom(env, atom);
  }

  return ret;
}

ERL_NIF_TERM mk_error(ErlNifEnv* env, const char* mesg) {
  return enif_make_tuple(env, mk_atom(env, "error"), mk_atom(env, mesg));
}
