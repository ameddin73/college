#include "all.h"
/* parse.c 1203c */
struct Usage usage_table[] = {
    { ADEF(VAL),           "(val x e)" },
    { ADEF(DEFINE),        "(define fun (formals) body)" },
    { ANXDEF(USE),         "(use filename)" },
    { ATEST(CHECK_EXPECT), "(check-expect exp-to-run exp-expected)" },
    { ATEST(CHECK_EXPECT), "(check-error exp)" },

    { SET,     "(set x e)" },
    { IFX,     "(if cond true false)" },
    { WHILEX,  "(while cond body)" },
    { BEGIN,   "(begin exp ... exp)" },
    { LAMBDAX, "(lambda (formals) body)" },

    { ALET(LET),     "(let ((var exp) ...) body)" },
    { ALET(LETSTAR), "(let* ((var exp) ...) body)" },
    { ALET(LETREC),  "(letrec ((var exp) ...) body)" },
    /* \uscheme\ [[usage_table]] entries added in exercises 1206a */
    /* add expected usage for each new syntactic form */
    /* \uscheme\ [[usage_table]] entries added in exercises ((answers)) 1497e */
    { SUGAR(CAND), "(&& exp ...)" },
    /* \uscheme\ [[usage_table]] entries added in exercises ((answers)) 1498c */
    { SUGAR(COR), "(|| exp ...)" },
    /* \uscheme\ [[usage_table]] entries added in exercises ((answers)) 1499g */
    { SUGAR(COND), "(cond (question-exp answer-exp) ...)" },
    /* \uscheme\ [[usage_table]] entries added in exercises ((answers)) 1500f */
    { SUGAR(RECORD), "(record record-name (field-name ...))" },
    /* \uscheme\ [[usage_table]] entries added in exercises 1232e */
    { ANEXP(BREAKX),     "(break)" },
    { ANEXP(CONTINUEX),  "(continue)" },
    { ANEXP(RETURNX),    "(return exp)" },
    { ANEXP(THROW),      "(throw exp)" },
    { ANEXP(TRY_CATCH),  "(try-catch body handler)" },
    { -1, NULL }
};
/* parse.c 1204b */
static ShiftFun quoteshifts[] = { sSexp,                 stop };
static ShiftFun setshifts[]   = { sName, sExp,           stop };
static ShiftFun ifshifts[]    = { sExp, sExp, sExp,      stop };
static ShiftFun whileshifts[] = { sExp, sExp,            stop };
static ShiftFun beginshifts[] = { sExps,                 stop };
static ShiftFun letshifts[]   = { sBindings, sExp,       stop };
static ShiftFun lambdashifts[]= { sNamelist, sExp,       stop };
static ShiftFun applyshifts[] = { sExp, sExps,           stop };
/* arrays of shift functions added to \uscheme\ in exercises 1205d */
/* define arrays of shift functions as needed for [[exptable]] rows */
/* arrays of shift functions added to \uscheme\ in exercises ((answers)) 1497c */
static ShiftFun conditionalshifts[] = { sExps, stop };
/* arrays of shift functions added to \uscheme\ in exercises ((answers)) 1499e */
static ShiftFun condshifts[] = { sQas, stop };
/* arrays of shift functions added to \uscheme\ in exercises ((answers)) 1500c */
ShiftFun recordshifts[] = { sName, setcontextname, sNamelist, stop };
/* arrays of shift functions added to \uscheme\ in exercises 1232b */
ShiftFun breakshifts[]  = { stop };
ShiftFun returnshifts[] = { sExp, stop };
ShiftFun tcshifts[]     = { sExp, sExp, stop };

struct ParserRow exptable[] = {
  { "set",    ANEXP(SET),     setshifts },
  { "if",     ANEXP(IFX),     ifshifts },
  { "while",  ANEXP(WHILEX),  whileshifts },
  { "begin",  ANEXP(BEGIN),   beginshifts },
  { "let",    ALET(LET),      letshifts },
  { "let*",   ALET(LETSTAR),  letshifts },
  { "letrec", ALET(LETREC),   letshifts },
  { "lambda", ANEXP(LAMBDAX), lambdashifts },
  { "quote",  ANEXP(LITERAL), quoteshifts }, 
  /* rows added to \uscheme's [[exptable]] in exercises 1205e */
  /* add a row for each new syntactic form of Exp */
  /* rows added to \uscheme's [[exptable]] in exercises ((answers)) 1497d */
  { "&&", SUGAR(CAND), conditionalshifts },
  /* rows added to \uscheme's [[exptable]] in exercises ((answers)) 1498b */
  { "||", SUGAR(COR), conditionalshifts },
  /* rows added to \uscheme's [[exptable]] in exercises ((answers)) 1499f */
  { "cond", SUGAR(COND), condshifts },
  /* rows added to \uscheme's [[exptable]] in exercises 1232c */
  { "break",     BREAKX,    breakshifts },
  { "continue",  CONTINUEX, breakshifts },
  { "return",    RETURNX,   returnshifts },
  { "throw",     THROW,     returnshifts },
  { "try-catch", TRY_CATCH, tcshifts },
  { NULL,     ANEXP(APPLY),   applyshifts }  // must come last
};
/* parse.c 1204c */
bool read_tick_as_quote = true;
/* parse.c 1205a */
Exp reduce_to_exp(int code, struct Component *comps) {
    switch(code) {
    case ANEXP(SET):     return mkSet(comps[0].name, comps[1].exp);
    case ANEXP(IFX):     return mkIfx(comps[0].exp, comps[1].exp, comps[2].exp);
    case ANEXP(WHILEX):  return mkWhilex(comps[0].exp, comps[1].exp);
    case ANEXP(BEGIN):   return mkBegin(comps[0].exps);
    case ALET(LET):
    case ALET(LETSTAR):
    case ALET(LETREC):   return mkLetx(code+LET-ALET(LET), 
                                       comps[0].names, comps[0].exps, comps[1].
                                                                           exp);
    case ANEXP(LAMBDAX): return mkLambdax(mkLambda(comps[0].names, comps[1].exp)
                                                                              );
    case ANEXP(APPLY):   return mkApply(comps[0].exp, comps[1].exps);
    case ANEXP(LITERAL):
    { Exp e = mkLiteral(comps[0].value);
      pushcontext(mkBeginStruct(mkEL(e, NULL)), roots.stack);
      return e;
    }
    /* cases for \uscheme's [[reduce_to_exp]] added in exercises 1205f */
    /* add a case for each new syntactic form of Exp */

/* cases for \uscheme's [[reduce_to_exp]] added in exercises ((answers)) 1497b */
    case SUGAR(CAND): return desugarAnd(comps[0].exps);

/* cases for \uscheme's [[reduce_to_exp]] added in exercises ((answers)) 1498d */
    case SUGAR(COR): return desugarOr(comps[0].exps);

/* cases for \uscheme's [[reduce_to_exp]] added in exercises ((answers)) 1499a */
    case SUGAR(COND):
        return desugarCond(comps[0].qa_pairs.questions, comps[0].
                                                              qa_pairs.answers);
    /* cases for \uscheme's [[reduce_to_exp]] added in exercises 1232d */
    case ANEXP(BREAKX):    return mkBreakx();
    case ANEXP(CONTINUEX): return mkContinuex();
    case ANEXP(RETURNX):   return mkReturnx(comps[0].exp);
    case ANEXP(THROW):     return mkThrow(comps[0].exp);
    case ANEXP(TRY_CATCH): return mkTryCatch(comps[0].exp, comps[1].exp);
    }
    assert(0);
}
/* parse.c 1205b */
XDef reduce_to_xdef(int code, struct Component *out) {
    switch(code) {
    case ADEF(VAL):    return mkDef(mkVal(out[0].name, out[1].exp));
    case ADEF(DEFINE): return mkDef(mkDefine(out[0].name,
                                             mkLambda(out[1].names, out[2].exp))
                                                                              );
    case ANXDEF(USE):  return mkUse(out[0].name);
    case ATEST(CHECK_EXPECT): 
                       return mkTest(mkCheckExpect(out[0].exp, out[1].exp));
    case ATEST(CHECK_ERROR): 
                       return mkTest(mkCheckError(out[0].exp));
    case ADEF(EXP):    return mkDef(mkExp(out[0].exp));
    /* cases for \uscheme's [[reduce_to_xdef]] added in exercises 1205g */
    /* add a case for each new syntactic form of definition */

/* cases for \uscheme's [[reduce_to_xdef]] added in exercises ((answers)) 1500b */
    case SUGAR(RECORD):
        return mkDef(mkDefs(desugarRecord(out[0].name, out[1].names)));
    default:           assert(0);  // incorrectly configured parser
    }
}
/* parse.c 1206b */
ParserResult sSexp(ParserState s) {
    if (s->input == NULL) {
        return INPUT_EXHAUSTED;
    } else {
        Par p = s->input->hd;
        halfshift(s);
        s->components[s->nparsed++].value = parsesx(p, s->context.source);
        return PARSED;
    }
}
/* parse.c 1206c */
ParserResult sBindings(ParserState s) {
    if (s->input == NULL) {
        return INPUT_EXHAUSTED;
    } else {
        Par p = s->input->hd;
        switch (p->alt) {
        case ATOM:
            usage_error(code_of_name(s->context.name), BAD_INPUT, &s->context);
            return BAD_INPUT; // not reached
        case LIST:
            halfshift(s);
            s->components[s->nparsed++] = parseletbindings(&s->context, p->
                                                                        u.list);
            return PARSED;
        }
        assert(0);
    }
}
/* parse.c 1207a */
Value parsesx(Par p, Sourceloc source) {
    switch (p->alt) {
    case ATOM:
        /* return [[p->u.atom]] interpreted as an S-expression 1207b */
        {
            Name n        = p->u.atom;
            const char *s = nametostr(n);

            char *t;                        // first nondigit in s
            long l = strtol(s, &t, 10);     // value of digits in s, if any
            if (*t == '\0' && *s != '\0')   // s is all digits
                return mkNum(l);
            else if (strcmp(s, "#t") == 0)
                return truev;
            else if (strcmp(s, "#f") == 0)
                return falsev;
            else if (strcmp(s, ".") == 0)
                synerror(source,
                    "this interpreter cannot handle . in quoted S-expressions");
            else
                return mkSym(n);
        }
    case LIST:
        /* return [[p->u.list]] interpreted as an S-expression 1207c */
        if (p->u.list == NULL)
            return mkNil();
        else {
            Value v = parsesx(p->u.list->hd, source);
            pushreg(&v);
            Value w = parsesx(mkList(p->u.list->tl), source);
            popreg(&v);
            Value pair = cons(v, w);
            cyclecheck(&pair);
            return pair;
        }
    }
    assert(0);
}
/* parse.c 1208a */
struct Component parseletbindings(ParsingContext context, Parlist input) {
    if (input == NULL) {
        struct Component output = { .names = NULL, .exps = NULL };
        return output;
    } else if (input->hd->alt == ATOM) {
        synerror(context->source,
                 "in %p, expected (... (x e) ...) in bindings, but found %p",
                 context->par, input->hd);
        assert(0);  // not reached
    } else {
        /* state and row are set up to parse one binding */
        struct ParserState s = mkParserState(input->hd, context->source);
        s.context = *context;
        static ShiftFun bindingshifts[] = { sName, sExp, stop };
        struct ParserRow row = { .code   = code_of_name(context->name)
                               , .shifts = bindingshifts
                               };
        rowparse(&row, &s);

        /* now parse the remaining bindings, then add the first at the front */
        struct Component output = parseletbindings(context, input->tl);
        output.names = mkNL(s.components[0].name, output.names);
        output.exps  = mkEL(s.components[1].exp,  output.exps);
        return output;
    }
}
/* parse.c 1208b */
Exp exp_of_atom (Name n) {
    if (n == strtoname("#t"))
        return mkLiteral(truev);
    else if (n == strtoname("#f"))
        return mkLiteral(falsev);

    const char *s = nametostr(n);
    char *t;                      // first nondigit in s, if any
    long l = strtol(s, &t, 10);   // number represented by s, if any
    if (*t == '\0' && *s != '\0') // all the characters in s are digits base 10
        return mkLiteral(mkNum(l));
    else
        return mkVar(n);
}
/* parse.c 1218a */
void check_exp_duplicates(Sourceloc source, Exp e) {
    switch (e->alt) {
    case LAMBDAX:
        if (duplicatename(e->u.lambdax.formals) != NULL)
            synerror(source, "formal parameter %n appears twice in lambda",
                     duplicatename(e->u.lambdax.formals));
        return;
    case LETX:
        if (e->u.letx.let != LETSTAR && duplicatename(e->u.letx.xs) != NULL)
            synerror(source, "bound name %n appears twice in %s",
                     duplicatename(e->u.letx.xs),
                     e->u.letx.let == LET ? "let" : "letrec");
        return;
    default:
        return;
    }
}

void check_def_duplicates(Sourceloc source, Def d) {
    if (d->alt == DEFINE && duplicatename(d->u.define.lambda.formals) != NULL)
        synerror(source,
                 "formal parameter %n appears twice in define",
                 duplicatename(d->u.define.lambda.formals));
}
/* parse.c 1218c */
Name namecat(Name n1, Name n2) {
    const char *s1 = nametostr(n1);
    const char *s2 = nametostr(n2);
    char *buf = malloc(strlen(s1) + strlen(s2) + 1);
    assert(buf);
    sprintf(buf, "%s%s", s1, s2);
    Name answer = strtoname(buf);
    free(buf);
    return answer;
}
/* parse.c 178 */
Exp desugarLetStar(Namelist xs, Explist es, Exp body) {
    if (xs == NULL || es == NULL) {
        assert(xs == NULL && es == NULL);
        return body;
    } else {
        return desugarLet(mkNL(xs->hd, NULL), mkEL(es->hd, NULL),
                          desugarLetStar(xs->tl, es->tl, body));
    }
}
/* parse.c ((answers)) 1497a */
Exp desugarLet(Namelist xs, Explist es, Exp body) {
    return mkApply(mkLambdax(mkLambda(xs, body)), es);
}
/* parse.c ((answers)) 1497g */
Exp desugarAnd(Explist args) {
    if (args == NULL)
        return mkLiteral(truev);
    else if (args->tl == NULL)
        return args->hd;
    else
        return mkIfx(args->hd, desugarAnd(args->tl), mkLiteral(falsev));
}
/* parse.c ((answers)) 1498f */
bool memberNL(Name x, Namelist xs) {
    if (xs == NULL)
        return false;
    else if (x == xs->hd)
        return true;
    else
        return memberNL(x, xs->tl);
}
/* parse.c ((answers)) 1498g */
Exp desugarOr(Explist args) {
    if (args == NULL)
        return mkLiteral(falsev);
    else if (args->tl == NULL)
        return args->hd;
    else {
        Exp e1 = args->hd;
        Exp e2 = desugarOr(args->tl);
        char xstring[64];   // name for let-bound temporary
        Namelist free = freevars(e2, NULL, NULL);
        for (int suffix = 1; ; suffix++) {
             size_t n = snprintf(xstring, sizeof(xstring), "x%d", suffix);
             assert(n < sizeof(xstring));
             Name x = strtoname(xstring);
             if (memberNL(x, free))
                 ; // try again
             else {
                 Exp ifx  = mkIfx(mkVar(x), mkVar(x), e2);
                 return mkLetx(LET, mkNL(x, NULL), mkEL(e1, NULL), ifx);
             }
        }
    }
}
/* parse.c ((answers)) 1499c */
static Exp errorexp(Exp arg) {
    return mkApply(mkVar(strtoname("error")), mkEL(arg, NULL));
}
/* parse.c ((answers)) 1499d */
Exp desugarCond(Explist questions, Explist answers) {
    if (questions && answers)
        return mkIfx(questions->hd, answers->hd,
                     desugarCond(questions->tl, answers->tl));
    else {
        Value message = mkSym(strtoname("cond:-all-question-results-were-false")
                                                                              );
        return errorexp(mkLiteral(message));
    }
}
/* parse.c ((answers)) 1499i */
ParserResult sQas(ParserState s) {
    struct qa_pairs qas;
    writeqapairs(&s->context, &qas, s->input);
    assert(s->nparsed < MAXCOMPS);
    s->input = NULL;
    s->components[s->nparsed++].qa_pairs = qas;
    return PARSED;
}
/* parse.c ((answers)) 1500a */
static ShiftFun qashifts[] = { sExp, sExp, stop };
void writeqapairs(ParsingContext context, struct qa_pairs *pairs, Parlist input)
                                                                               {
    if (input == NULL) {
        pairs->questions = NULL;
        pairs->answers   = NULL;
    } else if (input->hd->alt == ATOM) {
        synerror(context->source,

   "in %p, expected (... (exp exp) ...) in question/answer pairs, but found %p",
                 context->par, input->hd);
    } else {
        /* state and row are set up to parse one QA pair */
        struct ParserState s = mkParserState(input->hd, context->source);
        s.context = *context;
        struct ParserRow row = { .code   = code_of_name(context->name)
                               , .shifts = qashifts
                               };

        /* we parse left to right but add components right to left */
        rowparse(&row, &s);
        writeqapairs(context, pairs, input->tl);
        pairs->questions = mkEL(s.components[0].exp, pairs->questions);
        pairs->answers   = mkEL(s.components[1].exp, pairs->answers);
    }
}
/* parse.c ((answers)) 1500h */
static Def recordConstructor(Name recname, Namelist fieldnames);
static Def recordPredicate(Name recname);
static Deflist recordAccessors(Name recname, int preceding, Namelist fieldnames)
                                                                               ;

/* parse.c ((answers)) 1501a */
static Exp consexp(Exp car, Exp cdr) {
    return mkApply(mkVar(strtoname("cons")), mkEL(car, mkEL(cdr, NULL)));
}
static Exp carexp(Exp e);
static Exp cdrexp(Exp e) {
    return mkApply(mkVar(strtoname("cdr")), mkEL(e, NULL));
}
/* parse.c ((answers)) 1501b */
static Exp cdrs(int n, Exp e) {
    if (n == 0)
        return e;
    else
        return cdrexp(cdrs(n-1, e));
}
/* parse.c ((answers)) 1501c */
static Exp varlist(Namelist names) {
    if (names == NULL)
        return mkLiteral(mkNil());
    else
        return consexp(mkVar(names->hd), varlist(names->tl));
}
/* parse.c ((answers)) 1501d */
static Namelist prefix_the(Namelist names);

static Def recordConstructor(Name recname, Namelist fieldnames) {
    Name conname = namecat(strtoname("make-"), recname);
    Namelist argnames = prefix_the(fieldnames); 
    Exp body = consexp(mkLiteral(mkSym(conname)), varlist(argnames));
    return mkDefine(conname, mkLambda(argnames, body));
}
/* parse.c ((answers)) 1501e */
static Namelist prefix_the(Namelist names) {
    if (names == NULL)
        return NULL;
    else
        return mkNL(namecat(strtoname("the-"), names->hd), prefix_the(names->tl)
                                                                              );
}
/* parse.c ((answers)) 1502a */
static Def recordPredicate(Name recname) {
    if (recname == strtoname("pair"))
        runerror(
          "Records may not be called 'pair'; the 'pair?' variable is captured");
    Name predname = namecat(recname, strtoname("?"));
    Value tag = mkSym(namecat(strtoname("make-"), recname));
    Name r = strtoname("r");
    Exp body = desugarAnd(mkEL(mkApply(mkVar(strtoname("pair?")),
                                       mkEL(mkVar(r), NULL)),
                          mkEL(mkApply(mkVar(strtoname("=")),
                                       mkEL(carexp(mkVar(r)),
                                       mkEL(mkLiteral(tag), NULL))),
                          NULL)));
    return mkDefine(predname, mkLambda(mkNL(r, NULL), body));
}
/* parse.c ((answers)) 1502b */
static Deflist recordAccessors(Name recname, int preceding, Namelist fieldnames)
                                                                               {
    if (fieldnames == NULL)
        return NULL;
    else {
       Name field = fieldnames->hd;
       Name predname = namecat(recname, strtoname("?"));
       Name accessor = namecat(recname, namecat(strtoname("-"), field));
       Name r = strtoname("r");
       Exp fieldexp = carexp(cdrs(preceding+1, mkVar(r)));
       Exp body = mkIfx(mkApply(mkVar(predname), mkEL(mkVar(r), NULL)),
                        fieldexp,
                        errorexp(consexp(mkLiteral(mkSym(strtoname(
                                                           "value-passed-to"))),
                                 consexp(mkLiteral(mkSym(predname)),
                                 consexp(mkLiteral(mkSym(strtoname("is-not-a")))
                                                                               ,
                                 consexp(mkLiteral(mkSym(recname)),
                                 mkLiteral(mkNil())))))));
       Def d = mkDefine(accessor, mkLambda(mkNL(r, NULL), body));
       return mkDL(d, recordAccessors(recname, preceding+1, fieldnames->tl));
    }
}
/* parse.c ((answers)) 1502d */
/* functions for desugaring [[record]] definitions 221a */
Deflist desugarRecord(Name recname, Namelist fieldnames) {
    return mkDL(recordConstructor(recname, fieldnames),
           mkDL(recordPredicate(recname),
                recordAccessors(recname, 0, fieldnames)));
}
/* functions for desugaring [[record]] definitions 221b */
static Exp carexp(Exp e) {
    return mkApply(mkVar(strtoname("car")), mkEL(e, NULL));
}
