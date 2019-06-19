(val flipApp
  (type-lambda ('b)
    (lambda ([x : 'b])
      (type-lambda ('a)
        (lambda ([f : ('b -> 'a)])
          (f x))))))

(val cast
  (type-lambda ('a 'b)
    (lambda ([x : 'a])
      ((@ ((@ flipApp 'a) x) 'b) (lambda ([z : 'b]) z)))))
