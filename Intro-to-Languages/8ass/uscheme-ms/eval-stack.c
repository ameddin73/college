#include "all.h"
/* eval-stack.c 264a */
Value eval(Exp e, Env env) {
    Value v;
    Frame *fr;
    /* definition of static [[Exp hole]], which always has a hole 1232a */
    static struct Exp holeExp = { HOLE, { { NIL, { 0 } } } };
    static Exp hole = &holeExp;
    static Stack evalstack;

    /* ensure that [[evalstack]] is initialized and empty 1226b */
    if (evalstack == NULL)
        evalstack = emptystack();
    else
        clearstack(evalstack);
    /* ensure that [[evalstack]] is initialized and empty 1248b */
    assert(topframe(roots.stack) == NULL);
    roots.stack = evalstack;
    /* use the options in [[env]] to initialize the instrumentation 1228b */
    high_stack_mark = 0;
    show_high_stack_mark = 
        istrue(getoption(strtoname("&show-high-stack-mark"), env, falsev));
    /* use the options in [[env]] to initialize the instrumentation 1228g */
    {   Value *p = find(strtoname("&trace-stack"), env);
        if (p && p->alt == NUM)
            stack_trace_init(&p->u.num);
        else
            stack_trace_init(NULL);
    }
    /* use the options in [[env]] to initialize the instrumentation 1231e */
    optimize_tail_calls = 
        istrue(getoption(strtoname("&optimize-tail-calls"), env, truev));

    exp: 
        stack_trace_current_expression(e, env, evalstack);
        /* take a step from a state of the form $\seval e$ 265 */
        switch (e->alt) {
        case LITERAL:

/* start evaluating expression [[e->u.literal]] and transition to the next state 267a */
            v = e->u.literal;
            goto value;
        case VAR:   

/* start evaluating expression [[e->u.var]] and transition to the next state 267b */
            if (find(e->u.var, env) == NULL)
                runerror("variable %n not found", e->u.var);
            v = *find(e->u.var, env);
            goto value;
        case SET:

/* start evaluating expression [[e->u.set]] and transition to the next state 268a */
            if (find(e->u.set.name, env) == NULL)
                runerror("set unbound variable %n", e->u.set.name);
            pushcontext(mkSetStruct(e->u.set.name, hole), evalstack);
            e = e->u.set.exp;
            goto exp;
        case IFX:

/* start evaluating expression [[e->u.ifx]] and transition to the next state 268c */
            pushcontext(mkIfxStruct(hole, e->u.ifx.truex, e->u.ifx.falsex),
                                                                     evalstack);
            e = e->u.ifx.cond;
            goto exp;
        case WHILEX:

/* start evaluating expression [[e->u.whilex]] and transition to the next state 277c */
            pushcontext(mkWhilexStruct(e->u.whilex.cond, e->u.whilex.body),
                                                                     evalstack);
            e = e->u.whilex.cond;
            goto exp;
        case BEGIN:

/* start evaluating expression [[e->u.begin]] and transition to the next state 277a */
            pushcontext(mkBeginStruct(e->u.begin), evalstack);
            v = falsev;
            goto value;
        case LETX:
            if (/* [[e->u.letx]] contains no bindings 273a */
                e->u.letx.xs == NULL && e->u.letx.es == NULL) {
                 e = e->u.letx.body; // continue with the body
                 goto exp;
            } else {
                switch (e->u.letx.let) {
                   case LET:
/* start evaluating nonempty [[let]] expression [[e->u.letx]] and transition to the next state 273b */
                                 pushcontext(mkLetxStruct(e->u.letx.let, e->
                                                                      u.letx.xs,
                                                          copyEL(e->u.letx.es),
                                                                e->u.letx.body),
                                             evalstack);
                                 fr = topframe(evalstack);
                                 e  = head_replaced_with_hole(fr->
                                                             context.u.letx.es);
                                 assert(e);
                                 goto exp;
                   case LETSTAR:
/* start evaluating nonempty [[let*]] expression [[e->u.letx]] and transition to the next state 274a */
                                 pushenv_opt(env, LETXENV, evalstack);
                                 pushcontext(mkLetxStruct(e->u.letx.let, e->
                                       u.letx.xs, e->u.letx.es, e->u.letx.body),
                                             evalstack);
                                 fr = topframe(evalstack);
                                 assert(fr->context.u.letx.es);
                                 e = fr->context.u.letx.es->hd;
                                 assert(e);
                                 goto exp;
                   case LETREC:
/* start evaluating nonempty [[letrec]] expression [[e->u.letx]] and transition to the next state 273c */
                                 pushenv_opt(env, LETXENV, evalstack);
                                 {   Namelist xs;
                                     for (xs = e->u.letx.xs; xs; xs = xs->tl)
                                                                                
                                         env = bindalloc(xs->hd, unspecified(),
                                                                           env);
                                 }
                                 pushcontext(mkLetxStruct(e->u.letx.let, e->
                                                                      u.letx.xs,
                                                          copyEL(e->u.letx.es),
                                                                e->u.letx.body),
                                             evalstack);
                                 fr = topframe(evalstack);
                                 e  = head_replaced_with_hole(fr->
                                                             context.u.letx.es);
                                 assert(e);
                                 goto exp;
                   default:      assert(0);
                }
            }
        case LAMBDAX:

/* start evaluating expression [[e->u.lambdax]] and transition to the next state 267c */
            v = mkClosure(e->u.lambdax, env);
            goto value;
        case APPLY:

/* start evaluating expression [[e->u.apply]] and transition to the next state 270c */
            pushcontext(mkApplyStruct(mkHole(), copyEL(e->u.apply.actuals)),
                                                                     evalstack);
            topframe(evalstack)->syntax = e;
            e = e->u.apply.fn;
            goto exp;
        case BREAKX:

        /* start evaluating [[(break)]] and transition to the next state 279a */
            fr = topframe(evalstack);
            if (fr == NULL) 
                runerror("(break) occurred outside any loop");
            else
                switch (fr->context.alt) {
                    case WHILE_RUNNING_BODY:  // Break-Transfer
                        popframe(evalstack);
                        v = falsev;
                        goto value;
                    case LETXENV:
                        env = fr->context.u.letxenv;
                        popframe(evalstack);
                        goto exp;
                    case CALLENV:
                        runerror("(break) in function outside of any loop");
                    default:                  // Break-Unwind
                        popframe(evalstack);
                        goto exp;
                }
        case CONTINUEX:

/* start evaluating [[(continue)]] and transition to the next state ((answers)) (BUG: software can't tell where this code came from [NW3DWkps-3X91gr-1]) */
            fr = topframe(evalstack);
            if (fr == NULL) 
                runerror("(continue) occurred outside any loop");
            else
                switch (fr->context.alt) {
                    case WHILE_RUNNING_BODY:

/* transition to [[WHILEX]] and continue with condition in context [[fr->context.u.whilex]] 278b */
                        fr->context.alt = WHILEX;
                        e = fr->context.u.whilex.cond;
                        goto exp;
                    case LETXENV:
                        env = fr->context.u.letxenv;
                        popframe(evalstack);
                        goto exp;
                    case CALLENV:
                        runerror("(continue) in function outside of any loop");
                    default:
                        popframe(evalstack);
                        goto exp;
                }
        case RETURNX:

/* start evaluating expression [[e->u.returnx]] and transition to the next state 279c */
            pushcontext(mkReturnxStruct(hole), evalstack);
            e = e->u.returnx;
            goto exp;
        case THROW:

/* start evaluating expression [[e->u.throw]] and transition to the next state 279e */
            pushcontext(mkThrowStruct(hole), evalstack);
            e = e->u.throw;
            goto exp;
        case TRY_CATCH:

/* start evaluating expression [[e->u.try_catch]] and transition to the next state 280a */
            pushcontext(mkTryCatchStruct(e->u.try_catch.body, hole), evalstack);
            e = e->u.try_catch.handler;
            goto exp;

/* cases where the current item is an expression form that should appear only on the stack 1231g */
        case WHILE_RUNNING_BODY:
        case HOLE:
        case LETXENV:
        case CALLENV:
            assert(0);
        }
        assert(0);
    value: 
        stack_trace_current_value(v, env, evalstack);
        v = validate(v);

/* if [[evalstack]] is empty, return [[v]]; otherwise step from a state of the form $\sevalv {\mathtt{fr} \sconsop S}$ 264b */
        fr = topframe(evalstack);
        if (fr == NULL) {

         /* if [[show_high_stack_mark]] is set, show maximum stack size 1228c */
            if (show_high_stack_mark)
                fprintf(stderr, "High stack mark == %d\n", high_stack_mark);
            return v;
        } else {

/* take a step from a state of the form $\sevalv {\mathtt{fr} \sconsop S}$ 266 */
            switch (fr->context.alt) {
            case SET:

/* fill hole in context [[fr->context.u.set]] and transition to the next state 268b */
                assert(fr->context.u.set.exp->alt == HOLE);
                assert(find(fr->context.u.set.name, env) != NULL);
                *find(fr->context.u.set.name, env) = validate(v);
                popframe(evalstack);
                goto value;
            case IFX:

/* fill hole in context [[fr->context.u.ifx]] and transition to the next state 268d */
                assert(fr->context.u.ifx.cond->alt == HOLE);
                e = istrue(v) ? fr->context.u.ifx.truex : fr->
                                                           context.u.ifx.falsex;
                popframe(evalstack);
                goto exp;
            case WHILEX:

/* if [[v]] is true, continue with body in context [[fr->context.u.whilex]] 278a */
                if (istrue(validate(v))) {   // Small-Step-While-Condition-True
                    fr->context.alt = WHILE_RUNNING_BODY;
                    e = fr->context.u.whilex.body;
                    goto exp;
                } else {                     // Small-Step-While-Condition-False
                    popframe(evalstack);
                    v = falsev;
                    goto value;
                }
            case WHILE_RUNNING_BODY:

/* transition to [[WHILEX]] and continue with condition in context [[fr->context.u.whilex]] 278b */
                fr->context.alt = WHILEX;
                e = fr->context.u.whilex.cond;
                goto exp;
            case BEGIN:

 /* continue with the next expression in context [[fr->context.u.begin]] 277b */
                if (fr->context.u.begin) {   // Small-Step-Begin-Next-Expression
                    e = fr->context.u.begin->hd;
                    fr->context.u.begin = fr->context.u.begin->tl;
                    goto exp;
                } else {                     // Small-Step-Begin-Exhausted
                    popframe(evalstack);
                    goto value;
                }    
            case APPLY:

/* fill hole in context [[fr->context.u.apply]] and transition to the next state 271 */
                if (fr->context.u.apply.fn->alt == HOLE) {
                                                   // Small-Step-Apply-First-Arg
                    *fr->context.u.apply.fn = mkLiteralStruct(v);
                    e = head_replaced_with_hole(fr->context.u.apply.actuals);
                    if (e)
                        goto exp;
                                                   // Small-Step-Apply-First-Arg
                    else
                        goto apply_last_arg;
                                                      // empty list of arguments
                } else {                                    
                    e = transition_explist(fr->context.u.apply.actuals, v); 
                    if (e)
                        goto exp;
                                                    // Small-Step-Apply-Next-Arg
                    else goto
                        apply_last_arg;
                                                    // Small-Step-Apply-Last-Arg
                }
                apply_last_arg:   // Small-Step-Apply-Last-Arg (or no arguments)

/* apply [[fr->context]]'s [[fn]] to its [[actuals]]; free memory; transition to next state 272a */
                    {
                        Value     fn = asLiteral (fr->context.u.apply.fn);
                        Valuelist vs = asLiterals(fr->context.u.apply.actuals);
                        free  (fr->context.u.apply.fn);
                        freeEL(fr->context.u.apply.actuals);

                        popframe(evalstack);
                        
                        switch (fn.alt) {
                          case PRIMITIVE:

  /* apply [[fn.u.primitive]] to [[vs]] and transition to the next state 272b */
                              v = fn.u.primitive.function(fr->syntax,
                                                        fn.u.primitive.tag, vs);
                              freeVL(vs);
                              goto value;
                          case CLOSURE:

/* save [[env]], bind [[vs]] to [[fn.u.closure]]'s formals, and transition to evaluation of closure's body 272c */
                              {
                                  Namelist xs = fn.u.closure.lambda.formals;

                                  checkargc(e, lengthNL(xs), lengthVL(vs));
                                  pushenv_opt(env, CALLENV, evalstack);
                                  env = bindalloclist(xs, vs, fn.u.closure.env);
                                  e   = fn.u.closure.lambda.body;
                                  freeVL(vs);
                                  goto exp;
                              }
                          default:
                              runerror("%e evaluates to non-function %v in %e",
                                    fr->syntax->u.apply.fn, fn, fr->syntax);
                        }
                    }
            case LETX:
                switch (fr->context.u.letx.let) {
                   case LET:
                 /* continue with [[let]] context [[fr->context.u.letx]] 274b */
                                 e = transition_explist(fr->context.u.letx.es, v
                                                                              );
                                 if (e) {         // Small-Step-Next-Let-Exp 
                                     goto exp;
                                 } else {        // Small-Step-Let-Body
                                     Namelist xs  = fr->context.u.letx.xs;
                                                  // 1. Remember x's and v's    
                                     Explist  es  = fr->context.u.letx.es;
                                     Valuelist vs = asLiterals(es);
                                     e = fr->context.u.letx.body;
                                                  // 2. Update e                
                                     popframe(evalstack);
                                                  // 3. Pop the LET context     
                                     pushenv_opt(env, LETXENV, evalstack);
                                                  // 4. Push env                
                                     env = bindalloclist(xs, vs, env);
                                                  // 5. Update env              
                                     freeEL(es);
                                                  // 6. Recover memory          
                                     freeVL(vs);
                                     goto exp;
                                                  // 7. Transition to next state
                                 }
                   case LETSTAR:
                /* continue with [[let*]] context [[fr->context.u.letx]] 276a */
                                 assert(fr->context.u.letx.xs != NULL && fr->
                                                     context.u.letx.es != NULL);
                                 env = bindalloc(fr->context.u.letx.xs->hd, v,
                                                                           env);
                                 fr->context.u.letx.xs = fr->context.u.letx.xs->
                                                                             tl;
                                 fr->context.u.letx.es = fr->context.u.letx.es->
                                                                             tl;
                                 if (fr->context.u.letx.es) {
                                                  // Small-Step-Next-Letstar-Exp
                                     e = fr->context.u.letx.es->hd;
                                     goto exp;
                                 } else {
                                                      // Small-Step-Letstar-Body
                                     e = fr->context.u.letx.body;
                                     popframe(evalstack);
                                     goto exp;
                                 }
                   case LETREC:
              /* continue with [[letrec]] context [[fr->context.u.letx]] 275a */
                                 e = transition_explist(fr->context.u.letx.es, v
                                                                              );
                                 if (e) {  // Small-Step-Next-Letrec-Exp
                                     goto exp;
                                 } else {  // Small-Step-Letrec-Body

/* store values in [[fr->context.u.letx.es]] in locations bound to [[fr->context.u.letx.xs]] 275b */
                                     {
                                         Namelist xs = fr->context.u.letx.xs;
                                         Explist  es = fr->context.u.letx.es;
                                         while (es || xs) { 
                                             assert(es && xs);
                                             assert(find(xs->hd, env));
                                             *find(xs->hd, env) = asLiteral(es->
                                                                            hd);
                                             es = es->tl;
                                             xs = xs->tl;
                                         }
                                     };
                                     freeEL(fr->context.u.letx.es);
                                     e = fr->context.u.letx.body;
                                     popframe(evalstack);
                                     goto exp;
                                 }
                   default:      assert(0);
                }
            case LETXENV:

/* restore [[env]] from [[fr->context.u.letxenv]], pop the stack, and transition to the next state 276b */
                env = fr->context.u.letxenv;
                popframe(evalstack);
                goto value;
            case CALLENV:

/* restore [[env]] from [[fr->context.u.callenv]], pop the stack, and transition to the next state 276c */
                env = fr->context.u.callenv;
                popframe(evalstack);
                goto value;
            case TRY_CATCH:

/* if awaiting handler, install [[v]] and evaluate body, otherwise pop stack and transition to the next state 280b */
                if (fr->context.u.try_catch.handler->alt == HOLE) {
                                                            // Try-Catch-Handler
                    if (v.alt != CLOSURE && v.alt != PRIMITIVE) 
                        runerror(
             "Handler in try-catch is %v, but a handler must be a function", v);
                    e = fr->context.u.try_catch.body;
                    popframe(evalstack);
                    pushcontext(mkTryCatchStruct(hole, mkLiteral(v)), evalstack)
                                                                               ;
                    goto exp;
                } else {
                                                             // Try-Catch-Finish
                    assert(fr->context.u.try_catch.body->alt == HOLE);
                    popframe(evalstack);
                    goto value;
                }
            case RETURNX:

/* return [[v]] from the current function ((answers)) (BUG: software can't tell where this code came from [NW3DWkps-1Dqo2v-1]) */

/* discard frames from the stack until we find a call frame ((answers)) (BUG: software can't tell where this code came from [NW3DWkps-2r7bON-1]) */
                popframe(evalstack);
                for (;;) {
                  fr = topframe(evalstack);
                  if (fr == NULL)
                    runerror(
                "Evaluated (return) outside the context of any procedure call");
                  else if (fr->context.alt == CALLENV)
                    break;  // we now have a call frame on top of the stack
                  else if (fr->context.alt == LETXENV) {
                    env = fr->context.u.letxenv;
                    popframe(evalstack);
                  } else
                    popframe(evalstack);
                }
                goto value;
            case THROW:

/* throw [[v]] to the nearest [[try-catch]] that has an installed handler ((answers)) (BUG: software can't tell where this code came from [NW3DWkps-2YYHUt-1]) */
                popframe(evalstack);
                for (;;) {
                  fr = topframe(evalstack);
                  if (fr == NULL)
                    runerror(
                "Uncaught exception; evaluated (throw e) with no active try-catch");
                  else if (fr->context.alt == TRY_CATCH && fr->context.u.try_catch.handler->alt != HOLE) {
                      e = mkApply(fr->context.u.try_catch.handler, mkEL(mkLiteral(v), NULL));
                      popframe(evalstack);
                      goto exp;
                  } else if (fr->context.alt == CALLENV) {
                    env = fr->context.u.callenv;
                    popframe(evalstack);
                  } else if (fr->context.alt == LETXENV) {
                    env = fr->context.u.letxenv;
                    popframe(evalstack);
                  } else
                    popframe(evalstack);
                }
            case LITERAL:  // syntactic values never appear as contexts
            case VAR:
            case LAMBDAX:
            case HOLE:     // and neither do bare holes
            case BREAKX:   // nor do break or continue
            case CONTINUEX:
                assert(0);
            }
        }

        assert(0);
}
/* eval-stack.c 281 */
static int isenv(Exp e) {
    return e && (e->alt == CALLENV || e->alt == LETXENV);
}
                          
void pushenv_opt(Env env, Expalt context, Stack s) {
    if (optimize_tail_calls && topframe(s) && isenv(&topframe(s)->context)) {
        if (context == CALLENV && topframe(s)->context.alt == LETXENV) 
            topframe(s)->context = mkCallenvStruct(topframe(s)->
                                                             context.u.letxenv);
                           /* subtle and quick to anger */
    } else {
        struct Exp e = context == CALLENV ? mkCallenvStruct(env) :
                                                           mkLetxenvStruct(env);
        pushcontext(e, s);
    }
}
