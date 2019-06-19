#include "all.h"
/* env.c 1202a */
Value* find(Name name, Env env) {
    for (; env; env = env->tl)
        if (env->name == name)
            return env->loc;
    return NULL;
}
/* env.c 1202b */
void printenv(FILE *output, va_list_box *box) {
    char *prefix = " ";

    fprint(output, "{");
    for (Env env = va_arg(box->ap, Env); env; env = env->tl) {
        fprint(output, "%s%n -> %v", prefix, env->name, *env->loc);
        prefix = ", ";
    }
    fprint(output, " }");
}
/* env.c 1247b */
Env bindalloc(Name name, Value val, Env env) {
    Env newenv = malloc(sizeof(*newenv));
    assert(newenv != NULL);

    newenv->name = name;
    pushcontext(mkLetxenvStruct(env), roots.stack);
    newenv->loc  = allocate(val);
    popframe(roots.stack);
    newenv->tl   = env;
    return newenv;
}
/* env.c 1248a */
Env bindalloclist(Namelist xs, Valuelist vs, Env env) {
    Valuelist oldvals = vs;
    pushregs(oldvals);
    for (; xs && vs; xs = xs->tl, vs = vs->tl)
        env = bindalloc(xs->hd, vs->hd, env);
    popregs(oldvals);
    return env;
}
