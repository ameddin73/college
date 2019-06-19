(val id (type-lambda ('a) (lambda ([x : 'a]) x)))
(val id@int (@ id int))
(val ans (id@int 42))
