(define list? (xs) 
    (if (null? xs)
        #t
        (if (atom? xs)
            #f
            (list? (cdr xs))
        )
    )
)

(check-expect (list? 1) #f)
(check-expect (list? '()) #t)
(check-expect (list? (cons 1 (cons 2 '()))) #t)
(check-expect (list? (cons 1 2)) #f)
(check-expect (list? '(1 2)) #t)

(define list-prefix? (xs ys)
(if (> (length xs) (length ys))
    #f
    (if (null? xs)
        #t
        (if (equal? (car xs) (car ys))
            (list-prefix? (cdr xs) (cdr ys))
            #f
        )
    )
)
)

(check-expect (list-prefix? '() '(a b c)) #t)
(check-expect (list-prefix? '(a) '(a b c)) #t)
(check-expect (list-prefix? '(a b c) '(a b c)) #t)
(check-expect (list-prefix? '(b c) '(a b c)) #f)
(check-expect (list-prefix? '(a b c d) '(a b c)) #f)

