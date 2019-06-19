(val snd (type-lambda ('a 'b) (lambda ([x : 'a] [y : 'b]) y)))
(val snd@int&bool (@ snd int bool))
(val ans (snd@int&bool 0 #t))
