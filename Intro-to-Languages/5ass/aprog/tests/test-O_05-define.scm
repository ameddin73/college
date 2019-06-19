(define int fib ([n : int]) (if (< n 2) 1 (+ (fib (- n 2)) (fib (- n 1)))))
(val ans (fib 5))
