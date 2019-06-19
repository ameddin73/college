(val apply (type-lambda ('a 'b) (lambda ([f : ('a -> 'b)] [x : 'a]) (f x))))
(val bad (@ apply int list))
