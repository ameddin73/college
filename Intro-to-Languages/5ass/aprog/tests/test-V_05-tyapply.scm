(val fst (type-lambda ('a 'b) (lambda ([x : 'a] [y : 'b]) x)))
(val fst@int&bool (@ fst int bool))
(val ans (fst@int&bool 0 #t))
