;; Time spent on assignment: ~11 hrs
;; Collaborators: helped Kamil Bynoe


;; (list? x)
;; returns #t if x is a proper list 
;; and returns #f otherwise.
(define list? (x)
    (if (null? x)
            #t
                  (if (pair? x)
                              (list? (cdr x))
                                        #f)))

;; (prefix? xs ys)
;; returns #t if xs is a prefix of ys (using equal? to compare elements)
;; and returns #f otherwise. 
(define prefix? (xs ys)
    (if (null? xs)
            #t
                  (if (null? ys)
                              #f
                                        (and (equal? (car xs) (car ys))
                                                            (prefix? (cdr xs) (cdr ys))))))


(define even? (n) (= 0 (mod n 2)))
(val odd? (o not even?))
(val positive? ((curry <) 0))
(val zero? ((curry =) 0))
(val negative? ((curry >) 0))
(define flip (f) (lambda (b a) (f a b)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part A (Exercise 2)
;; DEFINE count HERE
(define count (x xs)
    (if (null? xs)
        0
        (if (equal? x (car xs))
            (+ 1 (count x (cdr xs)))
            (count x (cdr xs))
        )
    )
)

;; A.b (Exercise 2b)
;; DEFINE countall HERE
(define countall (x xs)
    (if (null? xs)
        0
        (if (atom? xs)
            (if (equal? x xs)
                1
                0
            )
            (if (atom? (car xs))
                (if (equal? x (car xs))
                    (+ 1 (countall x (cdr xs)))
                    (countall x (cdr xs))
                )
                (+ (countall x (car xs)) (countall x (cdr xs)))
            )
        )
    )
)

;; A.c (Exercise 2c)
;; DEFINE mirror HERE
(define mirror (xs)
    (foldl
        (lambda (xs a) 
            (if (atom? xs) 
                (cons xs a)
                (cons (mirror xs) a)
            ) 
        )
        '()
        xs
    )
)

;; A.d (Exercise 2d)
;; DEFINE flatten HERE
(define flatten (xs)
   (foldr
       (lambda (xs a)
           (if (null? xs)
               a
               (if (atom? xs)
                   (cons xs a)
                   (foldr cons a (flatten xs))
               )
           )
       )
       '()
       xs
   )
             
)

;; A.e (Exercise 2e)
;; DEFINE sublist? HERE
(define sublist? (xs ys)
    (if (prefix? xs ys)
        #t
        (if (null? ys)
            #f
            (sublist? xs (cdr ys))
        )
    )
)

;; A.f (Exercise 2f)
;; DEFINE subseq? HERE
(define subseq? (xs ys)
    (if (null? xs)
        #t
        (if (null? ys)
            #f
            (if (= (car xs) (car ys))
                (subseq? (cdr xs) (cdr ys))
                (subseq? xs (cdr ys))
            )
        )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part B

;; B.1 (take)
;; DEFINE take HERE
(define take (n xs)
    (if (null? xs)
        '()
        (if (> n 0)
            (cons (car xs) (take (- n 1) (cdr xs)))
            '()
        )
    )
)

;; B.2 (drop)
;; DEFINE drop HERE
(define drop (n xs)
    (if (null? xs)
        '()
        (if (> n 0)
            (drop (- n 1) (cdr xs))
            xs
        )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part C (interleave)

;; DEFINE interleave HERE
(define interleave (xs ys)
    (if (null? xs)
        ys
        (if (null? ys)
            xs
            (append (cons (car xs) (cons (car ys) '())) (interleave (cdr xs) (cdr ys)))
        )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part D (permutation?) !bonus!

;; DEFINE permutation? HERE
;;(define permlist (x ys)
;;    (if (null? ys)
;;        ys
;;        (if (= x (car ys))
;;            (cdr ys)
;;            (cons (car ys) (permlist x (cdr ys)))
;;        )
;;    )
;;)

(define permutation? (xs ys)
    (if (and (null? xs) (null? ys))
        #t
        (if (null? xs)
            #f
            (if (sublist? (cons (car xs) '()) ys)
                (permutation? (cdr xs)
                    (letrec 
                        ((permlist (lambda (x ys)
                            (if (null? ys)
                                ys
                                (if (= x (car ys))
                                    (cdr ys)
                                    (cons (car ys) (permlist x (cdr ys)))
                                )
                            )
                        )))
                        (permlist (car xs) ys)
                    )
                )
                #f
            )
        )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part E (Exercise 10)

;; E.a (Exercise 10a)
;; DEFINE takewhile HERE
(define takewhile (f xs)
    (if (null? xs)
        xs
        (if (f (car xs))
            (cons (car xs) (takewhile f (cdr xs)))
            '()
        )
    )    
)

;; E.b (Exercise 10b)
;; DEFINE dropwhile HERE
(define dropwhile (f xs)
    (if (null? xs)
        xs
        (if (f (car xs))
            (dropwhile f (cdr xs))
            xs
        )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part F (arg-max)

;; DEFINE arg-max HERE
(define arg-max (f xs)
    (if (null? (cdr xs))
        (car xs)
        (if (< (f (car xs)) (f (arg-max f (cdr xs))))
            (arg-max f (cdr xs))
            (car xs)
        )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part G (Exercise 14)

;; G.b (Exercise 14b)
;; DEFINE max* HERE
(define max* (xs)
    (car (foldr
        (lambda (xs a) 
            (if (> xs (car a))
                (cons xs a)
                a
            )
        )
        (cons (car xs) '())
        xs
    ))
)

;; G.c (Exercise 14c)
;; DEFINE gcd* HERE
(define gcd* (xs)
    (foldr
        gcd
        (max* xs)
        xs
    )
)

;; G.g (Exercise 14h)
;; DEFINE append-via-fold HERE
(define append-via-fold (xs ys)
    (foldr cons ys xs)
)

;; G.i (Exercise 14j)
;; DEFINE reverse-via-fold HERE
(define reverse-via-fold (xs)
    (foldl cons '() xs)
)

;; G.j (Exercise 14k)

(define insert (x xs)
    (if (null? xs)
            (list1 x)
                  (if (< x (car xs))
                              (cons x xs)
                                        (cons (car xs) (insert x (cdr xs))))))

;; DEFINE insertion-sort HERE
(define insertion-sort (xs)
    (foldr
        (lambda (xs a)
            (insert xs a)
        )
        '()
        xs
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part H (Exercise 19)

(val emptyset (lambda (x) #f))
(define member? (x s) (s x))

;; H.1 (Exercise 19c)
;; DEFINE add-element HERE
(define add-element (x xs)
    (lambda (s) (or (= x s) (xs s)))
)

;; H.2 (Exercise 19c)
;; DEFINE union HERE
(define union (xs ys)
    (lambda (s) (or (xs s) (ys s)))
)

;; H.3 (Exercise 19c)
;; DEFINE inter HERE
(define inter (xs ys)
    (lambda (s) (and (xs s) (ys s)))
)

;; H.4 (Exercise 19c)
;; DEFINE diff HERE
(define diff (xs ys)
    (lambda (s) (and (xs s) (not (ys s))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part I

;; DEFINE clamp HERE
(define clamp (f low high)
    (lambda (s)
        (let  ((func (f s))) 
            (if (> func  high)
                high
                (if (< func low)
                    low
                    func
                )
            )
        )
    )
)



(val fn-ex1 (lambda (x) (* 2 x)))
(val fn-ex2 (lambda (x) (+ x 1)))
(val fn-ex3 (lambda (x) (+ (* x x) (+ x 1))))
(val fn-ex4 (let 
    ((first #t)) 
    (lambda (x) 
        (if first 
            (begin (set first #f) x) 
            (error '(fn-ex4 called twice))
        )
    )
))
