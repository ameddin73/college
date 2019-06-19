(val apply (type-lambda ('a 'b) (lambda ([f : ('a -> 'b)] [x : 'a]) (f x))))
(val apply@int&int (@ apply int int))
(val ans (apply@int&int (lambda ([x : int]) (+ x 1)) 23))
