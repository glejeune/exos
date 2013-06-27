#include <stdlib.h>
#include <pwd.h>
#include <grp.h>
#include <stdio.h>
#include <sys/types.h>

#include "nif_helpers.h"

static int load(ErlNifEnv *env, void **priv, ERL_NIF_TERM load_info) {
  return 0;
}

static ERL_NIF_TERM username(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  register struct passwd *pw;
  int uid;

  if(!enif_is_number(env, argv[0])) {
    return mk_error(env, "wrong_uid");
  }
  enif_get_int(env, argv[0], &uid);

  pw = getpwuid((uid_t)uid);
  if(pw) {
    return enif_make_string(env, pw->pw_name, ERL_NIF_LATIN1);
  }
  return mk_error(env, "failed");
}

static ERL_NIF_TERM uid(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  register uid_t uid;

  uid = geteuid();
  return enif_make_int(env, uid);
}

static ERL_NIF_TERM group(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  int gid;
  register struct group *gr;

  if(!enif_is_number(env, argv[0])) {
    return mk_error(env, "wrong_gid");
  }
  enif_get_int(env, argv[0], &gid);

  gr = getgrgid((gid_t)gid);
  if(gr) {
    return enif_make_string(env, gr->gr_name, ERL_NIF_LATIN1);
  }
  return mk_error(env, "wrong_gid");
}

static ERL_NIF_TERM gid(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  register gid_t gid;

  gid = getegid();
  return enif_make_int(env, gid);
}

static ERL_NIF_TERM home(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  register struct passwd *pw;
  register uid_t uid;

  uid = geteuid();
  pw = getpwuid(uid);
  if(pw) {
    return enif_make_string(env, pw->pw_dir, ERL_NIF_LATIN1);
  }
  return mk_error(env, "failed");
}


static ErlNifFunc nif_funcs[] = {
  {"username", 1, username},
  {"uid", 0, uid},
  {"group", 1, group},
  {"gid", 0, gid},
  {"home", 0, home}
};

ERL_NIF_INIT(Elixir.ExOS, nif_funcs, load, NULL, NULL, NULL)
