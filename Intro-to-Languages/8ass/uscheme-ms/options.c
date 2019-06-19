#include "all.h"
/* options.c 1231d */
Value getoption(Name name, Env env, Value defaultval) {
    Value *p = find(name, env);
    if (p)
        return *p;
    else
        return defaultval;
}
