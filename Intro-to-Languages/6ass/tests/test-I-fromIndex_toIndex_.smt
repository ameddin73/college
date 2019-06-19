(test-fromIndex-toIndex (xv:name: XVectorTester xv01 #xv01))
(test-fromIndex-toIndex (xv:name: XVectorTester xv02 #xv02))
(test-fromIndex-toIndex (xv:name: XVectorTester xv03 #xv03))
(test-fromIndex-toIndex (xv:name: XVectorTester xv04 #xv04))
(test-fromIndex-toIndex (xv:name: XVectorTester xv05 #xv05))
(test-fromIndex-toIndex (xv:name: XVectorTester xv06 #xv06))
(test-fromIndex-toIndex (xv:name: XVectorTester xv07 #xv07))
(test-fromIndex-toIndex (xv:name: XVectorTester xv08 #xv08))
(test-fromIndex-toIndex (xv:name: XVectorTester xv09 #xv09))
(test-fromIndex-toIndex (xv:name: XVectorTester xv10 #xv10))
(test-fromIndex-toIndex (xv:name: XVectorTester xv11 #xv11))
(test-fromIndex-toIndex (xv:name: XVectorTester xv12 #xv12))
(test-fromIndex-toIndex (xv:name: XVectorTester xv13 #xv13))

;; Hide Array constructor, since fromIndex:toIndex: should not
;; explicitly construct a data structure proportional in size to the
;; sliced xvector.
(class Array Array ()
  (class-method new: (_) (error: self #fromIndex:toIndex-should-not-use-arrays)))

(test-fromIndex-toIndex (xv:name: XVectorTester xv01 #xv01))
(test-fromIndex-toIndex (xv:name: XVectorTester xv02 #xv02))
(test-fromIndex-toIndex (xv:name: XVectorTester xv03 #xv03))
(test-fromIndex-toIndex (xv:name: XVectorTester xv04 #xv04))
(test-fromIndex-toIndex (xv:name: XVectorTester xv05 #xv05))
(test-fromIndex-toIndex (xv:name: XVectorTester xv06 #xv06))
(test-fromIndex-toIndex (xv:name: XVectorTester xv07 #xv07))
(test-fromIndex-toIndex (xv:name: XVectorTester xv08 #xv08))
(test-fromIndex-toIndex (xv:name: XVectorTester xv09 #xv09))
(test-fromIndex-toIndex (xv:name: XVectorTester xv10 #xv10))
(test-fromIndex-toIndex (xv:name: XVectorTester xv11 #xv11))
(test-fromIndex-toIndex (xv:name: XVectorTester xv12 #xv12))
(test-fromIndex-toIndex (xv:name: XVectorTester xv13 #xv13))

;; Restore Array constructor.
(class Array Array ()
  (class-method new: primitive arrayNew:))
