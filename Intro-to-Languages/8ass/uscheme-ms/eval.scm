;;;scheme.nw:6699
(val emptystore '((next 0)))
;;;scheme.nw:3614
(define find-c (key alist success-cont failure-cont)
   (letrec
       ((search (lambda (alist)
                   (if (null? alist)
                       (failure-cont)
                       (if (equal? key (alist-first-key alist))
                           (success-cont (alist-first-attribute alist))
                           (search (cdr alist)))))))
     (search alist)))
;;;scheme.nw:6704
(val sigma emptystore)
(define load  (l)   (find-c l sigma (lambda (x) x)
                            (lambda () (error (list2 'unbound-location: l)))))
(define store (l v) (begin (set sigma (bind l v sigma)) v))
;;;scheme.nw:6713
(define allocate (value)
  (let*
    ((loc (load 'next)))
    (begin
       (store 'next (+ loc 1))
       (store loc value)
       loc)))
;;;scheme.nw:6727
(define bindalloc (name v env)
  (bind name (allocate v) env))
(define bindalloclist (xs vs env)
  (if (and (null? xs) (null? vs))
    env
    (bindalloclist (cdr xs) (cdr vs) (bindalloc (car xs) (car vs) env))))
;;;scheme.nw:6755
(define apply-prim (prim)
  (lambda (args)
    (if (= (length args) 1)
      (prim (car args))
      (if (= (length args) 2)
        (prim (car args) (cadr args))
        (error (list4 'all-primitives-expect-one-or-two-arguments---got (length args)
                      ': args))))))
;;;scheme.nw:6776
(define primenv ()
  (let*
      ((env '())
       (env (bindalloc '+ (apply-prim +) env))
       (env (bindalloc '- (apply-prim -) env))
       (env (bindalloc '* (apply-prim *) env))
       (env (bindalloc '/ (apply-prim /) env))
       (env (bindalloc '< (apply-prim <) env))
       (env (bindalloc '> (apply-prim >) env))
       (env (bindalloc '= (apply-prim =) env))
       (env (bindalloc 'car        (apply-prim car)        env))
       (env (bindalloc 'cdr        (apply-prim cdr)        env))
       (env (bindalloc 'cons       (apply-prim cons)       env))
       (env (bindalloc 'println    (apply-prim println)    env))
       (env (bindalloc 'print      (apply-prim print)      env))
       (env (bindalloc 'printu     (apply-prim printu)     env))
       (env (bindalloc 'error      (apply-prim error)      env))
       (env (bindalloc 'boolean?   (apply-prim boolean?)   env))
       (env (bindalloc 'null?      (apply-prim null?)      env))
       (env (bindalloc 'number?    (apply-prim number?)    env))
       (env (bindalloc 'symbol?    (apply-prim symbol?)    env))
       (env (bindalloc 'procedure? (apply-prim procedure?) env))
       (env (bindalloc 'pair?      (apply-prim pair?)      env)))
    env))
;;;scheme.nw:6840
(define find-variable (x env)
  (find-c x env (lambda (x) x) (lambda () (error (list2 'unbound-variable: x)))))
;;;scheme.nw:6882
(define unary (name f rest)
  (if (= (length rest) 1)
    (f (car rest))
    (error (list5 name 'expression-needs-one-argument,-got (length rest) 'in rest))))
;;;scheme.nw:6887
(define binary (name f rest)
  (if (= (length rest) 2)
    (f (car rest) (cadr rest))
    (error (list5 name 'expression-needs-two-arguments,-got (length rest) 'in rest))))
;;;scheme.nw:6892
(define trinary (name f rest)
  (if (= (length rest) 3)
    (f (car rest) (cadr rest) (caddr rest))
    (error (list5 name 'expression-needs-three-arguments,-got (length rest) 'in
                  rest))))
;;;scheme.nw:6812
(define eval (env)
   (letrec
       ((ev (lambda (e) 
;;;scheme.nw:6827
(if (symbol? e)
  (load (find-variable e env))
  (if (atom? e)
    e
    (let ((first (car e))
          (rest  (cdr e)))
      (if (exists? ((curry =) first) '(set if while lambda quote begin))
          
;;;scheme.nw:6856
(if (= first 'set)    (binary  'set    meta-set    rest)
(if (= first 'if)     (trinary 'if     meta-if     rest)
(if (= first 'while)  (binary  'while  meta-while  rest)
(if (= first 'lambda) (binary  'lambda meta-lambda rest)
(if (= first 'quote)  (unary   'quote  meta-quote  rest)
(if (= first 'begin)  (meta-begin rest)
(error (list2 'this-cannot-happen---bad-ast first))))))))
;;;scheme.nw:6835
          
;;;scheme.nw:6848
((ev first) (map ev rest))
;;;scheme.nw:6835
                                                                                       ))))
;;;scheme.nw:6814
                                                                                        ))
        
;;;scheme.nw:6901
(meta-quote (lambda (e) e))
(meta-if    (lambda (e1 e2 e3) (if (ev e1) (ev e2) (ev e3))))
(meta-while (lambda (condition body) (while (ev condition) (ev body))))
;;;scheme.nw:6907
(meta-set   (lambda (v e)
              (let ((loc (find-variable v env)))
                 (if (null? loc)
                    (error (list2 'set-unbound-variable v))
                    (store loc (ev e))))))
;;;scheme.nw:6916
(meta-begin (lambda (es) (foldl (lambda (e result) (ev e)) '() es)))
;;;scheme.nw:6922
(meta-lambda (lambda (formals body)
               (if (all? symbol? formals)
                 (lambda (actuals)
                   ((eval (bindalloclist formals actuals env)) body))
                 (error (list2 'lambda-with-bad-formals: formals)))))
;;;scheme.nw:6815
                                                                             )
     ev))

;;;scheme.nw:6960
(define meta-val (env) 
  (lambda (x e)
    (if (symbol? x)
        (let* ((env (find-c x env (lambda (_) env) (lambda () (bindalloc x '() env)))))
          (begin
            ((eval env) (list3 'set x e))
            env))
        (error (list2 'val-tried-to-bind-non-symbol x)))))
;;;scheme.nw:6971
(define meta-define (env) 
  (lambda (name formals body)
    ((meta-val env) name (list3 'lambda formals body))))
;;;scheme.nw:6980
(define meta-exp (e env)
  (begin
    (println ((eval env) e))
    env))
;;;scheme.nw:6933
(define evaldef (e env)
  (if (pair? e)
    (let ((first (car e))
          (rest  (cdr e)))
      (if (= first 'val)
        (binary 'val (meta-val env) rest)
        (if (= first 'define)
            (trinary 'define (meta-define env) rest)
            (meta-exp e env))))
    (meta-exp e env)))
;;;scheme.nw:6991
(define read-eval-print (env es)
    (foldl evaldef env es))
;;;scheme.nw:7000
(define run (es)
  (begin (read-eval-print (primenv) es) 0))
