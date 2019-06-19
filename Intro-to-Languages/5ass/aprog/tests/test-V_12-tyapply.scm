(val cast
  (type-lambda ('a 'b)
    (lambda ([x : 'a])
      (@ (type-lambda ('a) x) 'b))))
