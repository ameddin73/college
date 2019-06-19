#include "all.h"
/* impcore.c 52b */
int main(int argc, char *argv[]) {
    bool interactive  = (argc <= 1) || ((strcmp(argv[1], "-q") != 0) && (strcmp(argv[1], "-qq") != 0));
    Prompts prompts  = interactive ? STD_PROMPTS : NO_PROMPTS;
    Echo echo  = (argc <= 1) || (strcmp(argv[1], "-qq") != 0) ? ECHOES : NO_ECHOES;
    set_toplevel_error_format(interactive ? WITHOUT_LOCATIONS : WITH_LOCATIONS);
    if (getenv("NOERRORLOC")) set_toplevel_error_format(WITHOUT_LOCATIONS);
                                                            /*testing*/ /*OMIT*/

    /* install conversion specifications for [[print]] and [[fprint]] 1194c */
    installprinter('c', printchar);
    installprinter('d', printdecimal);
    installprinter('e', printexp);
    installprinter('E', printexplist);
    installprinter('f', printfun);
    installprinter('n', printname);
    installprinter('N', printnamelist);
    installprinter('p', printpar);
    installprinter('P', printparlist);
    installprinter('s', printstring);
    installprinter('t', printdef);
    installprinter('v', printvalue);
    installprinter('V', printvaluelist);
    installprinter('%', printpercent);

    Valenv globals   = mkValenv(NULL, NULL);
    Funenv functions = mkFunenv(NULL, NULL);
    /* install the initial basis in [[functions]] 53b */
    {
        static const char *prims[] = 
           { "+", "-", "*", "/", "<", ">", "=", "println", "print", "printu", 0
                                                                              };
        for (const char **p = prims; *p; p++) {
            Name x = strtoname(*p);
            bindfun(x, mkPrimitive(x), functions);
        }
    }
    /* install the initial basis in [[functions]] 53d */
    {
        const char *fundefs = 

       /* predefined {\impcore} functions, as strings (generated by a script) */

             "(define and (b c) (if b c b))\n"
             "(define or  (b c) (if b b c))\n"
             "(define not (b)   (if b 0 1))\n"
             "(define <= (x y) (not (> x y)))\n"
             "(define >= (x y) (not (< x y)))\n"
             "(define != (x y) (not (= x y)))\n"
             "(define mod (m n) (- m (* n (/ m n))))\n";
        if (setjmp(errorjmp))
            assert(0); // if error in predefined function, die horribly
        readevalprint(stringxdefs("predefined functions", fundefs), globals,
                                                          functions, NO_ECHOES);
    }

    XDefstream xdefs = filexdefs("standard input", stdin, prompts);

    while (setjmp(errorjmp))
        ;
    readevalprint(xdefs, globals, functions, echo);
    return 0;
}
/* impcore.c 1080b */
bool read_tick_as_quote = false;