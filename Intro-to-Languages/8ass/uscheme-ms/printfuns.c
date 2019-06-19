#include "all.h"
/* printfuns.c 1088c */
void printname(FILE *output, va_list_box *box) {
    Name np = va_arg(box->ap, Name);
    fputs(np == NULL ? "<null>" : nametostr(np), output);
}
/* printfuns.c 1088d */
void printchar(FILE *output, va_list_box *box) {
    int c = va_arg(box->ap, int);
    putc(c, output);
}
/* printfuns.c 1088f */
void printpar(FILE *output, va_list_box *box) {
    Par p = va_arg(box->ap, Par);
    if (p == NULL) {
        fprint(output, "<null>");
        return;
    }

    switch (p->alt){
    case ATOM:
        fprint(output, "%n", p->u.atom);
        break;
    case LIST:
        fprint(output, "(%P)", p->u.list);
        break;
    }
}
/* printfuns.c 1210a */
static bool nameinlist(Name n, Namelist xs) {
    for (; xs; xs=xs->tl)
        if (n == xs->hd)
            return true;
    return false;
}
/* printfuns.c 1210b */
static Namelist addname(Name n, Namelist xs) {
    if (nameinlist(n, xs))
        return xs;
    else
        return mkNL(n, xs);
}
/* printfuns.c 1210c */
static Namelist addfree(Name n, Namelist bound, Namelist free) {
    if (nameinlist(n, bound))
        return free;
    else
        return addname(n, free);
}
/* printfuns.c 1211a */
Namelist freevars(Exp e, Namelist bound, Namelist free) {
    switch (e->alt) {
    case LITERAL:
        break;
    case VAR:
        free = addfree(e->u.var, bound, free);
        break;
    case IFX:
        free = freevars(e->u.ifx.cond, bound, free);
        free = freevars(e->u.ifx.truex, bound, free);
        free = freevars(e->u.ifx.falsex, bound, free);
        break;
    case WHILEX:
        free = freevars(e->u.whilex.cond, bound, free);
        free = freevars(e->u.whilex.body, bound, free);
        break;
    case BEGIN:
        for (Explist es = e->u.begin; es; es = es->tl)
            free = freevars(es->hd, bound, free);
        break;
    case SET:
        free = addfree(e->u.set.name, bound, free);
        free = freevars(e->u.set.exp, bound, free);
        break;
    case APPLY:
        free = freevars(e->u.apply.fn, bound, free);
        for (Explist es = e->u.apply.actuals; es; es = es->tl)
            free = freevars(es->hd, bound, free);
        break;
    case LAMBDAX:
        /* let [[free]] be the free variables for [[e->u.lambdax]] 1211b */
        for (Namelist xs = e->u.lambdax.formals; xs; xs = xs->tl)
            bound = addname(xs->hd, bound);
        free = freevars(e->u.lambdax.body, bound, free);
        break;
    case LETX:
        /* let [[free]] be the free variables for [[e->u.letx]] 1212 */
        switch (e->u.letx.let) {
            Namelist xs;   // used to visit every bound name
            Explist  es;   // used to visit every expression that is bound
        case LET:
            for (es = e->u.letx.es; es; es = es->tl)
                free = freevars(es->hd, bound, free);
            for (xs = e->u.letx.xs; xs; xs = xs->tl)
                bound = addname(xs->hd, bound);
            free = freevars(e->u.letx.body, bound, free);
            break;
        case LETSTAR:
            for (xs = e->u.letx.xs, es = e->u.letx.es
               ; xs && es
               ; xs = xs->tl, es = es->tl
               ) 
            {
                free  = freevars(es->hd, bound, free);
                bound = addname(xs->hd, bound);
            }
            free = freevars(e->u.letx.body, bound, free);
            break;
        case LETREC:
            for (xs = e->u.letx.xs; xs; xs = xs->tl)
                bound = addname(xs->hd, bound);
            for (es = e->u.letx.es; es; es = es->tl)
                free = freevars(es->hd, bound, free);
            free = freevars(e->u.letx.body, bound, free);
            break;
        }
        break;
    /* extra cases for finding free variables in {\uscheme} expressions 1222b */
    /* extra cases for finding free variables in {\uscheme} expressions 1233b */
    case BREAKX:
        break;
    case CONTINUEX:
        break;
    case RETURNX:
        free = freevars(e->u.returnx, bound, free);
        break;
    case THROW:
        free = freevars(e->u.throw, bound, free);
        break;
    case TRY_CATCH:
        free = freevars(e->u.try_catch.body, bound, free);
        free = freevars(e->u.try_catch.handler, bound, free);
        break;
    /* extra cases for finding free variables in {\uscheme} expressions 1234 */
    case HOLE:
    case CALLENV:
    case LETXENV:
    case WHILE_RUNNING_BODY:
        assert(0);
        break;
    }
    return free;
}
/* printfuns.c 1213a */
static void printnonglobals(FILE *output, Namelist xs, Env env, int depth);

static void printclosureat(FILE *output, Lambda lambda, Env env, int depth) {
    if (depth > 0) {
        Namelist vars = freevars(lambda.body, lambda.formals, NULL);
        fprint(output, "<%\\, {", lambda);
        printnonglobals(output, vars, env, depth - 1);
        fprint(output, "}>");
    } else {
        fprint(output, "<procedure>");
    }
}
/* printfuns.c 1213b */
static void printvalueat(FILE *output, Value v, int depth);
/* helper functions for [[printvalue]] 1214b */
static void printtail(FILE *output, Value v, int depth) {
    switch (v.alt) {
    case NIL:
        fprint(output, ")");
        break;
    case PAIR:
        fprint(output, " ");
        printvalueat(output, *v.u.pair.car, depth);
        printtail(output, *v.u.pair.cdr, depth);
        break;
    default:
        fprint(output, " . ");
        printvalueat(output, v, depth);
        fprint(output, ")");
        break;
    }
}
static void printvalueat(FILE *output, Value v, int depth) {
    switch (v.alt){
    case NIL:
        fprint(output, "()");
        return;
    case BOOLV:
        fprint(output, v.u.boolv ? "#t" : "#f");
        return;
    case NUM:
        fprint(output, "%d", v.u.num);
        return;
    case SYM:
        fprint(output, "%n", v.u.sym);
        return;
    case PRIMITIVE:
        fprint(output, "<procedure>");
        return;
    case PAIR:
        fprint(output, "(");
if (v.u.pair.car == NULL) fprint(output, "<NULL>"); else  // OMIT
        printvalueat(output, *v.u.pair.car, depth);
if (v.u.pair.cdr == NULL) fprint(output, " <NULL>)"); else // OMIT
        printtail(output, *v.u.pair.cdr, depth);
        return;
    case CLOSURE:
        printclosureat(output, v.u.closure.lambda, v.u.closure.env, depth);
        return;
    default:
        fprint(output, "<unknown v.alt=%d>", v.alt);
        return;
    }
}
/* printfuns.c 1214a */
void printvalue(FILE *output, va_list_box *box) {
    printvalueat(output, va_arg(box->ap, Value), 0);
}
/* printfuns.c 1214c */
Env *globalenv;
static void printnonglobals(FILE *output, Namelist xs, Env env, int depth) {
    char *prefix = "";
    for (; xs; xs = xs->tl) {
        Value *loc = find(xs->hd, env);
        if (loc && (globalenv == NULL || find(xs->hd, *globalenv) != loc)) {
            fprint(output, "%s%n -> ", prefix, xs->hd);
            prefix = ", ";
            printvalueat(output, *loc, depth);
        }
    }
}
/* printfuns.c 1219a */
void printdef(FILE *output, va_list_box *box) {
    Def d = va_arg(box->ap, Def);
    if (d == NULL) {
        fprint(output, "<null>");
        return;
    }

    switch (d->alt) {
    case VAL:
        fprint(output, "(val %n %e)", d->u.val.name, d->u.val.exp);
        return;
    case EXP:
        fprint(output, "%e", d->u.exp);
        return;
    case DEFINE:
        fprint(output, "(define %n %\\)", d->u.define.name, d->u.define.lambda);
        return;
    case DEFS:
                                                                        /*OMIT*/
        for (Deflist ds = d->u.defs; ds; ds = ds->tl)
                                                                        /*OMIT*/
            fprint(output, "%t%s", ds->hd, ds->tl != NULL ? "\n" : "");
                                                                        /*OMIT*/
        return;
                                                                        /*OMIT*/
    }
    assert(0);
}
/* printfuns.c 1219b */
void printxdef(FILE *output, va_list_box *box) {
    XDef d = va_arg(box->ap, XDef);
    if (d == NULL) {
        fprint(output, "<null>");
        return;
    }

    switch (d->alt) {
    case USE:
        fprint(output, "(use %n)", d->u.use);
        return;
    case TEST:
        fprint(output, "CANNOT PRINT UNIT TEST XXX\n");
        return;
    case DEF:
        fprint(output, "%t", d->u.def);
        return;
    }
    assert(0);
}
/* printfuns.c 1220 */
static void printlet(FILE *output, Exp let) {
    switch (let->u.letx.let) {
    case LET:
        fprint(output, "(let (");
        break;
    case LETSTAR:
        fprint(output, "(let* (");
        break;
    case LETREC:
        fprint(output, "(letrec (");
        break;
    default:
        assert(0);
    }
    Namelist xs;  // visits every let-bound name
    Explist es;   // visits every bound expression
    for (xs = let->u.letx.xs, es = let->u.letx.es; 
         xs && es;
         xs = xs->tl, es = es->tl)
        fprint(output, "(%n %e)%s", xs->hd, es->hd, xs->tl?" ":"");
    fprint(output, ") %e)", let->u.letx.body);
}   
/* printfuns.c 1221a */
void printexp(FILE *output, va_list_box *box) {
    Exp e = va_arg(box->ap, Exp);
    if (e == NULL) {
        fprint(output, "<null>");
        return;
    }

    switch (e->alt) {
    case LITERAL:
        if (e->u.literal.alt == NUM || e->u.literal.alt == BOOLV)
            fprint(output, "%v", e->u.literal);
        else
            fprint(output, "'%v", e->u.literal);
        break;
    case VAR:
        fprint(output, "%n", e->u.var);
        break;
    case IFX:
        fprint(output, "(if %e %e %e)", e->u.ifx.cond, e->u.ifx.truex, e->
                                                                  u.ifx.falsex);
        break;
    case WHILEX:
        fprint(output, "(while %e %e)", e->u.whilex.cond, e->u.whilex.body);
        break;
    case BEGIN:
        fprint(output, "(begin%s%E)", e->u.begin ? " " : "", e->u.begin);
        break;
    case SET:
        fprint(output, "(set %n %e)", e->u.set.name, e->u.set.exp);
        break;
    case LETX:
        printlet(output, e);
        break;
    case LAMBDAX:
        fprint(output, "%\\", e->u.lambdax);
        break;
    case APPLY:
        fprint(output, "(%e%s%E)", e->u.apply.fn,
              e->u.apply.actuals ? " " : "", e->u.apply.actuals);
        break;
    /* extra cases for printing {\uscheme} ASTs 1222a */
    /* extra cases for printing {\uscheme} ASTs 1233a */
    case BREAKX:
        fprint(output, "(break)");
        break;
    case CONTINUEX:
        fprint(output, "(continue)");
        break;
    case RETURNX:
        fprint(output, "(return %e)", e->u.returnx);
        break;
    case THROW:
        fprint(output, "(throw %e)", e->u.throw);
        break;
    case TRY_CATCH:
        fprint(output, "(try-catch %e %e)", e->u.try_catch.body, e->
                                                           u.try_catch.handler);
        break;
    case HOLE:
        fprint(output, "<*>");
        break;
    case LETXENV:
        fprintf(stderr, "Restore let environment %p", (void*)e->u.letxenv);
        break;
    case CALLENV:
        fprintf(stderr, "Restore caller's environment %p", (void*)e->u.callenv);
        break;
    case WHILE_RUNNING_BODY:
        fprint(output, "(while-running-body %e %e)", e->u.whilex.cond, e->
                                                                 u.whilex.body);
        break;
    default:
        assert(0);
    }
}
/* printfuns.c 1221b */
void printlambda(FILE *output, va_list_box *box) {
    Lambda l = va_arg(box->ap, Lambda);
    fprint(output, "(lambda (%N) %e)", l.formals, l.body);
}
