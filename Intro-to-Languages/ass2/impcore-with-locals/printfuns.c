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
/* printfuns.c 1195 */
void printexp(FILE *output, va_list_box *box) {
    Exp e = va_arg(box->ap, Exp);
    if (e == NULL) {
        fprint(output, "<null>");
        return;
    }

    switch (e->alt){
    case LITERAL:
        fprint(output, "%v", e->u.literal);
        break;
    case VAR:
        fprint(output, "%n", e->u.var);
        break;
    case SET:
        fprint(output, "(set %n %e)", e->u.set.name, e->u.set.exp);
        break;
    case IFX:
        fprint(output, "(if %e %e %e)", e->u.ifx.cond, e->u.ifx.truex, e->
                                                                  u.ifx.falsex);
        break;
    case WHILEX:
        fprint(output, "(while %e %e)", e->u.whilex.cond, e->u.whilex.exp);
        break;
    case BEGIN:
        fprint(output, "(begin%s%E)", e->u.begin?" ":"", e->u.begin);
        break;
    case APPLY:
        fprint(output, "(%n%s%E)", e->u.apply.name,
                      e->u.apply.actuals?" ":"", e->u.apply.actuals);
        break;
    }
}
/* printfuns.c 1196a */
void printdef(FILE *output, va_list_box *box) {
    Def d = va_arg(box->ap, Def);
    if (d == NULL) {
        fprint(output, "<null>");
        return;
    }

    switch (d->alt) {
    case VAL:
        fprint(output, "(val %n %e)", d->u.val.name, d->u.val.exp);
        break;
    case EXP:
        fprint(output, "%e", d->u.exp);
        break;
    case DEFINE:
        fprint(output, "(define %n (%N) (locals %N) %e)", d->u.define.name,
                      d->u.define.userfun.formals,
           d->u.define.userfun.locals,
              d->u.define.userfun.body);
        break;
    }
}
/* printfuns.c 1196b */
void printxdef(FILE *output, va_list_box *box) {
    XDef d = va_arg(box->ap, XDef);
    if (d == NULL) {
        fprint(output, "<null>");
        return;
    }

    switch (d->alt) {
    case USE:
        fprint(output, "(use %n)", d->u.use);
        break;
    case TEST:
        /* print unit test [[d->u.test]] to file [[output]] 1197a */
        {   UnitTest t = d->u.test;
            switch (t->alt) {
            case CHECK_EXPECT:
                fprint(output, "(check-expect %e %e)",
                       t->u.check_expect.check, t->u.check_expect.expect);
                break;
            case CHECK_ERROR:
                fprint(output, "(check-error %e)", t->u.check_error);
                break;
            default:
                assert(0);
            }
        }
        break;
    case DEF:
        fprint(output, "%t", d->u.def);
        break;
    }
    assert(0);
}
/* printfuns.c 1197b */
void printvalue(FILE *output, va_list_box *box) {
    Value v = va_arg(box->ap, Value);
    fprint(output, "%d", v);
}
/* printfuns.c 1197c */
void printfun(FILE *output, va_list_box *box) {
    Fun f = va_arg(box->ap, Fun);
    switch (f.alt) {
    case PRIMITIVE:
        fprint(output, "<%n>", f.u.primitive);
        break;
    case USERDEF:
        fprint(output, "<userfun (%N) %e>", f.u.userdef.formals,
                                                              f.u.userdef.body);
        break;
    default:
        assert(0);
    }
}
