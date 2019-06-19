#include "all.h"
/* scheme.c 170a */
int main(int argc, char *argv[]) {
    bool interactive  = (argc <= 1) || ((strcmp(argv[1], "-q") != 0) && (strcmp(argv[1], "-qq") != 0));
    Prompts prompts  = interactive ? STD_PROMPTS : NO_PROMPTS;
    Echo echo  = (argc <= 1) || (strcmp(argv[1], "-qq") != 0) ? ECHOES : NO_ECHOES;
    set_toplevel_error_format(interactive ? WITHOUT_LOCATIONS : WITH_LOCATIONS);
    if (getenv("NOERRORLOC")) set_toplevel_error_format(WITHOUT_LOCATIONS);
                                                            /*testing*/ /*OMIT*/

    initvalue();
    
    /* install printers 170b */
    installprinter('c', printchar);
    installprinter('d', printdecimal);
    installprinter('e', printexp);
    installprinter('E', printexplist);
    installprinter('\\', printlambda);
    installprinter('n', printname);
    installprinter('N', printnamelist);
    installprinter('p', printpar);
    installprinter('P', printparlist);
    installprinter('r', printenv);
    installprinter('s', printstring);
    installprinter('t', printdef);
    installprinter('v', printvalue);
    installprinter('V', printvaluelist);
    installprinter('%', printpercent);

    Env env = NULL;
    initallocate(&env);
    /* install primitive functions into [[env]] 164c */
    #define xx(NAME, TAG, FUNCTION) \
        env = bindalloc(strtoname(NAME), mkPrimitive(TAG, FUNCTION), env);
    #include "prim.h"
    #undef xx
    /* install predefined functions into [[env]] 170c */
    const char *fundefs =
       /* predefined {\uscheme} functions, as strings (generated by a script) */

                            "(define caar (xs) (car (car xs)))\n"
                            "(define cadr (xs) (car (cdr xs)))\n"
                            "(define cdar (xs) (cdr (car xs)))\n"
                            "(define list1 (x)     (cons x '()))\n"
                            "(define list2 (x y)   (cons x (list1 y)))\n"
                            "(define list3 (x y z) (cons x (list2 y z)))\n"
                            "(define length (xs)\n"
                            "  (if (null? xs) 0\n"
                            "    (+ 1 (length (cdr xs)))))\n"
                            "(define and (b c) (if b  c  b))\n"
                            "(define or  (b c) (if b  b  c))\n"
                            "(define not (b)   (if b #f #t))\n"

"(define atom? (x) (or (number? x) (or (symbol? x) (or (boolean? x) (null? x)))))\n"
                            "(define equal? (s1 s2)\n"
                            "  (if (or (atom? s1) (atom? s2))\n"
                            "    (= s1 s2)\n"

           "    (and (equal? (car s1) (car s2)) (equal? (cdr s1) (cdr s2)))))\n"
                            "(define append (xs ys)\n"
                            "  (if (null? xs)\n"
                            "     ys\n"
                            "     (cons (car xs) (append (cdr xs) ys))))\n"

                           "(define revapp (xs ys) ; reverse xs and append ys\n"
                            "  (if (null? xs)\n"
                            "     ys\n"
                            "     (revapp (cdr xs) (cons (car xs) ys))))\n"
                            "(define reverse (xs) (revapp xs '()))\n"
                            "(define make-alist-pair (k a) (list2 k a))\n"

                          "(define alist-pair-key        (pair)  (car  pair))\n"

                          "(define alist-pair-attribute  (pair)  (cadr pair))\n"

   "(define alist-first-key       (alist) (alist-pair-key       (car alist)))\n"

   "(define alist-first-attribute (alist) (alist-pair-attribute (car alist)))\n"
                            "(define bind (k a alist)\n"
                            "  (if (null? alist)\n"
                            "    (list1 (make-alist-pair k a))\n"
                            "    (if (equal? k (alist-first-key alist))\n"
                            "      (cons (make-alist-pair k a) (cdr alist))\n"

                          "      (cons (car alist) (bind k a (cdr alist))))))\n"
                            "(define find (k alist)\n"
                            "  (if (null? alist) '()\n"
                            "    (if (equal? k (alist-first-key alist))\n"
                            "      (alist-first-attribute alist)\n"
                            "      (find k (cdr alist)))))\n"
                            "(define o (f g) (lambda (x) (f (g x))))\n"

                      "(define curry   (f) (lambda (x) (lambda (y) (f x y))))\n"
                            "(define uncurry (f) (lambda (x y) ((f x) y)))\n"
                            "(define filter (p? xs)\n"
                            "  (if (null? xs)\n"
                            "    '()\n"
                            "    (if (p? (car xs))\n"
                            "      (cons (car xs) (filter p? (cdr xs)))\n"
                            "      (filter p? (cdr xs)))))\n"
                            "(define map (f xs)\n"
                            "  (if (null? xs)\n"
                            "    '()\n"
                            "    (cons (f (car xs)) (map f (cdr xs)))))\n"
                            "(define exists? (p? xs)\n"
                            "  (if (null? xs)\n"
                            "    #f\n"
                            "    (if (p? (car xs)) \n"
                            "      #t\n"
                            "      (exists? p? (cdr xs)))))\n"
                            "(define all? (p? xs)\n"
                            "  (if (null? xs)\n"
                            "    #t\n"
                            "    (if (p? (car xs))\n"
                            "      (all? p? (cdr xs))\n"
                            "      #f)))\n"
                            "(define foldr (op zero xs)\n"
                            "  (if (null? xs)\n"
                            "    zero\n"
                            "    (op (car xs) (foldr op zero (cdr xs)))))\n"
                            "(define foldl (op zero xs)\n"
                            "  (if (null? xs)\n"
                            "    zero\n"
                            "    (foldl op (op (car xs) zero) (cdr xs))))\n"
                            "(define <= (x y) (not (> x y)))\n"
                            "(define >= (x y) (not (< x y)))\n"
                            "(define != (x y) (not (= x y)))\n"
                            "(define max (x y) (if (> x y) x y))\n"
                            "(define min (x y) (if (< x y) x y))\n"
                            "(define mod (m n) (- m (* n (/ m n))))\n"

                         "(define gcd (m n) (if (= n 0) m (gcd n (mod m n))))\n"

                     "(define lcm (m n) (if (= m 0) 0 (* m (/ n (gcd m n)))))\n"
                            "(define min* (ns) (foldr min (car ns) (cdr ns)))\n"
                            "(define max* (ns) (foldr max (car ns) (cdr ns)))\n"
                            "(define gcd* (ns) (foldr gcd 0 ns))\n"
                            "(define lcm* (ns) (foldr lcm 1 ns))\n"
                            "(define caar  (sx) (car (car  sx)))\n"
                            "(define cdar  (sx) (cdr (car  sx)))\n"
                            "(define cadr  (sx) (car (cdr  sx)))\n"
                            "(define cddr  (sx) (cdr (cdr  sx)))\n"
                            "(define caaar (sx) (car (caar sx)))\n"
                            "(define cdaar (sx) (cdr (caar sx)))\n"
                            "(define caadr (sx) (car (cadr sx)))\n"
                            "(define cdadr (sx) (cdr (cadr sx)))\n"
                            "(define cadar (sx) (car (cdar sx)))\n"
                            "(define cddar (sx) (cdr (cdar sx)))\n"
                            "(define caddr (sx) (car (cddr sx)))\n"
                            "(define cdddr (sx) (cdr (cddr sx)))\n"
                            "(define list1 (x)               (cons x '()))\n"

                         "(define list2 (x y)             (cons x (list1 y)))\n"

                       "(define list3 (x y z)           (cons x (list2 y z)))\n"

                     "(define list4 (x y z a)         (cons x (list3 y z a)))\n"

                   "(define list5 (x y z a b)       (cons x (list4 y z a b)))\n"

                 "(define list6 (x y z a b c)     (cons x (list5 y z a b c)))\n"

               "(define list7 (x y z a b c d)   (cons x (list6 y z a b c d)))\n"

             "(define list8 (x y z a b c d e) (cons x (list7 y z a b c d e)))\n"
                            "(define takewhile (p? xs)\n"
                            "  (if (null? xs)\n"
                            "     '()\n"
                            "     (if (p? (car xs))\n"
                            "         (cons (car xs) (takewhile p? (cdr xs)))\n"
                            "         '())))\n"
                            "(define dropwhile (p? xs)\n"
                            "  (if (null? xs)\n"
                            "     '()\n"
                            "     (if (p? (car xs))\n"
                            "         (dropwhile p? (cdr xs))\n"
                            "         xs)))\n";
    if (setjmp(errorjmp))
        assert(0);  // fail if error occurs in predefined functions
    readevalprint(stringxdefs("predefined functions", fundefs), &env, NO_ECHOES)
                                                                               ;

    XDefstream xdefs = filexdefs("standard input", stdin, prompts);

    while (setjmp(errorjmp))
        ;
    readevalprint(xdefs, &env, echo);
    return 0;
}
