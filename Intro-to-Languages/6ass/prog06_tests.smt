;; util.smt
(class Unit Object () (method print ()) (method println ()))
(val unit (new Unit))

(class BlockFn1 Block () (method value (i) (mod: i 31)))
(class BlockFn2 Block () (method value (i) (mod: (* i i) 31)))
(class BlockFn3 Block () (method value (i) (reciprocal i)))
(class BlockFn4 Block () (method value (i) (ifTrue:ifFalse: (= 0 (mod: i 2)) {(asFraction (+ i i))} {(reciprocal (+ i i))})))

(class XVectorTester Object
  (xv name size isMag isNum isInt isFrac isFloat vals)
  (class-method xv:name: (xv name) (init (xv:name: (new self) xv name)))
  (class-method xv:name:-no-init (xv name) (xv:name: (new self) xv name))
  (method xv:name: (thatXV thatName) (set xv thatXV) (set name thatName) self)
  (method init ()
    (set size (size xv))
    (set isMag (or: (= 0 size) {(isKindOf: (elem: xv 1) Magnitude)}))
    (set isNum (or: (= 0 size) {(isKindOf: (elem: xv 1) Number)}))
    (set isInt (or: (= 0 size) {(isKindOf: (elem: xv 1) Integer)}))
    (set isFrac (or: (= 0 size) {(isKindOf: (elem: xv 1) Fraction)}))
    (set isFloat (or: (= 0 size) {(isKindOf: (elem: xv 1) Float)}))
    (set vals (new List))
    (add: vals nil)
    (add: vals true)
    (add: vals false)
    (add: vals 0)
    (add: vals 1)
    (add: vals 2)
    (add: vals 42)
    self)
  (method test-at-ifAbsent () (locals tmp)
    (print #Testing) (print s-space) (println name)
    (do: #(1 2 3 4 5) (block (i)
      (set tmp i)
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-space) (print s-lbrace) (print #nil) (print s-rbrace) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))))
    (do: #(3 30) (block (i)
      (set tmp (- (raisedToInteger: 2 i) 1))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-space) (print s-lbrace) (print #nil) (print s-rbrace) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))
      (set tmp (raisedToInteger: 2 i))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-space) (print s-lbrace) (print #nil) (print s-rbrace) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))
      (set tmp (+ (raisedToInteger: 2 i) 1))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-space) (print s-lbrace) (print #nil) (print s-rbrace) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))))
    (do: #(30 3) (block (i)
      (set tmp (negated (+ (raisedToInteger: 2 i) 1)))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-space) (print s-lbrace) (print #nil) (print s-rbrace) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))
      (set tmp (negated (raisedToInteger: 2 i)))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-space) (print s-lbrace) (print #nil) (print s-rbrace) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))
      (set tmp (negated (- (raisedToInteger: 2 i) 1)))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-space) (print s-lbrace) (print #nil) (print s-rbrace) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))))
    (do: #(5 4 3 2 1) (block (i)
      (set tmp (negated i))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-space) (print s-lbrace) (print #nil) (print s-rbrace) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))))
    unit)
  (method test-do () (locals tmp)
    (print #Testing) (print s-space) (println name)
    (ifTrue: (< size 20) {(print s-lparen) (print #print) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println xv)})
    (ifTrue: (< size 4096) {
      (ifFalse: (| isFrac isFloat) {(do: vals (block (x)
        (print s-lparen) (print #includes:) (print s-space) (print name) (print s-space) (print x) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (includes: xv x))
        (print s-lparen) (print #occurrencesOf:) (print s-space) (print name) (print s-space) (print x) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (occurrencesOf: xv x))))})
      (ifTrue: isNum {
        (print s-lparen) (print #detect:ifNone:) (print s-space) (print name) (print s-space) (print #negative) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (detect:ifNone: xv (block (x) (negative x)) {nil}))
        (print s-lparen) (print #detect:ifNone:) (print s-space) (print name) (print s-space) (print #positive) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (detect:ifNone: xv (block (x) (positive x)) {nil}))})})
     unit)
  (method test-sum ()
    (print #Testing) (print s-space) (println name)
    (ifTrue: (& isNum (< size 256)) {(print s-lparen) (print #sum) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (sum xv))})
    unit)
  (method test-product ()
    (print #Testing) (print s-space) (println name)
    (ifTrue: (& isNum (< size 15)) {(print s-lparen) (print #product) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (product xv))})
    unit)
  (method test-min ()
    (print #Testing) (print s-space) (println name)
    (ifTrue: (& isMag (< 0 size)) {(print s-lparen) (print #min) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (min xv))})
    unit)
  (method test-max ()
    (print #Testing) (print s-space) (println name)
    (ifTrue: (& isMag (< 0 size)) {(print s-lparen) (print #max) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (max xv))})
    unit)
  (method test-eq:: (othrXVs othrNs) (locals tmp xv' name' size' isMag' isNum' isInt' isFrac' isFloat')
    (print #Testing) (print s-space) (println name)
    (do: vals (block (x)
      (print s-lparen) (print #=) (print s-space) (print name) (print s-space) (print x) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (= xv x))))
    (set tmp 1)
    (timesRepeat: (size othrXVs) {
      (set xv' (at: othrXVs tmp))
      (set name' (at: othrNs tmp))
      (set size' (size xv'))
      (set isMag' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Magnitude)}))
      (set isNum' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Number)}))
      (set isInt' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Integer)}))
      (set isFrac' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Fraction)}))
      (set isFloat' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Float)}))
      (ifTrue: (| (| (= 0 size) (= 0 size')) (& (eqv: isFrac isFrac') (eqv: isFloat isFloat'))) {
        (print s-lparen) (print #=) (print s-space) (print name) (print s-space) (print name') (print s-rparen) (print s-space) (print #=>) (print s-space) (println (= xv xv'))})
      (set tmp (+ tmp 1))})
    unit)
  (method test-lt:: (othrXVs othrNs) (locals tmp xv' name' size' isMag' isNum' isInt' isFrac' isFloat')
    (print #Testing) (print s-space) (println name)
    (set tmp 1)
    (timesRepeat: (size othrXVs) {
      (set xv' (at: othrXVs tmp))
      (set name' (at: othrNs tmp))
      (set size' (size xv'))
      (set isMag' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Magnitude)}))
      (set isNum' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Number)}))
      (set isInt' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Integer)}))
      (set isFrac' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Fraction)}))
      (set isFloat' (or: (= 0 size') {(isKindOf: (elem: xv' 1) Float)}))
      (ifTrue: (& (& isMag isMag') (| (| (= 0 size) (= 0 size')) (& (eqv: isInt isInt') (& (eqv: isFrac isFrac') (eqv: isFloat isFloat'))))) {
        (print s-lparen) (print #<) (print s-space) (print name) (print s-space) (print name') (print s-rparen) (print s-space) (print #=>) (print s-space) (println (< xv xv'))})
      (set tmp (+ tmp 1))})
    unit)
  (method test-fromIndex-toIndex () (locals fromIndices toIndices tmp)
    (set fromIndices #(1 1 1 1 2 2 -1 -2 -3 -5 -2 -4 -1 -2 -3 -4 -5))
    (set toIndices   #(1 2 3 5 2 4 -1 -1 -1 -1 -2 -2  1  2  3  4  5))
    (print #Testing) (print s-space) (println name)
    (ifTrue: (> size 5) {
      (set tmp 1)
      (timesRepeat: (size fromIndices) {
        (print s-lparen) (print #fromIndex:toIndex:) (print s-space) (print name) (print s-space) (print (at: fromIndices tmp)) (print s-space) (print (at: toIndices tmp)) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (fromIndex:toIndex: xv (at: fromIndices tmp) (at: toIndices tmp)))
        (set tmp (+ tmp 1))})})
    unit)
  (method test-debug ()
    (print #Testing) (print s-space) (println name)
    (print s-lparen) (print #debug) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (debug xv) (print s-newline)
    unit)
  (method test-size ()
    (print #Testing) (print s-space) (println name)
    (print s-lparen) (print #size) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (size xv))
    unit)
  (method test-elem () (locals tmp)
    (print #Testing) (print s-space) (println name)
    (do: #(1 2 3 4 5 6 7 8 9 10 15 16 17 18 19 20 51 52 53 54 55 101 102 103 104 105 501 502 503 504 505 1001 1002 1003 1004 1005) (block (i)
      (set tmp i)
      (ifTrue: (<= i (size xv)) {(print s-lparen) (print #elem) (print s-space) (print name) (print s-space) (print tmp) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (elem: xv tmp))})))
    unit)
  (method test-all:: (othrXVs othrNs)
    (test-at-ifAbsent self)
    (test-do self)
    (test-sum self)
    (test-product self)
    (test-min self)
    (test-max self)
    (test-eq:: self othrXVs othrNs)
    (test-lt:: self othrXVs othrNs)
    (test-fromIndex-toIndex self)
    unit)
)

(val xvs unit)
(begin (set xvs (new List)) unit)
(val ns unit)
(begin (set ns (new List)) unit)

(val xv01 unit)
(begin (set xv01 (withArr: ArrayXVector #())) (add: xvs xv01) (add: ns #xv01) unit)

(val xv02 unit)
(begin (set xv02 (withArr: ArrayXVector #(1))) (add: xvs xv02) (add: ns #xv02) unit)

(val xv03 unit)
(begin (set xv03 (withArr: ArrayXVector #(1 2 3))) (add: xvs xv03) (add: ns #xv03) unit)

(val xv04 unit)
(begin (set xv04 (withArr: ArrayXVector #(1 2 3 4 5 6))) (add: xvs xv04) (add: ns #xv04) unit)

(val xv05 unit)
(begin (set xv05 (withArr: ArrayXVector #(-6))) (add: xvs xv05) (add: ns #xv05) unit)

(val xv06 unit)
(begin (set xv06 (withArr: ArrayXVector #(-6 -5 -4))) (add: xvs xv06) (add: ns #xv06) unit)

(val xv07 unit)
(begin (set xv07 (withArr: ArrayXVector #(-6 -5 -4 -3 -2 -1))) (add: xvs xv07) (add: ns #xv07) unit)

(val xv08 unit)
(begin (set xv08 (withArr: ArrayXVector (from: Array (collect: (asSet #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)) (new BlockFn1))))) (add: xvs xv08) (add: ns #xv08) unit)

(val xv09 unit)
(begin (set xv09 (withArr: ArrayXVector (from: Array (collect: (asSet #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)) (new BlockFn2))))) (add: xvs xv09) (add: ns #xv09) unit)

(val xv10 unit)
(begin (set xv10 (withArr: ArrayXVector (from: Array (collect: (asSet #(1 2 3 4 5)) (new BlockFn3))))) (add: xvs xv10) (add: ns #xv10) unit)

(val xv11 unit)
(begin (set xv11 (withArr: ArrayXVector (from: Array (collect: (asSet #(1 2 3 4 5 6 7 8 9 10)) (new BlockFn4))))) (add: xvs xv11) (add: ns #xv11) unit)

(val xv12 unit)
(begin (set xv12 (withArr: ArrayXVector (from: Array (collect: (asSet #(1 2)) (block (i) (= i 1)))))) (add: xvs xv12) (add: ns #xv12) unit)

(val xv13 unit)
(begin (set xv13 (withArr: ArrayXVector (from: Array (collect: (asSet #(1 2)) (block (i) nil))))) (add: xvs xv13) (add: ns #xv13) unit)

(begin (print s-newline) (println ###########) unit)

;; test-A-at:ifAbsent:.smt
(test-at-ifAbsent (xv:name: XVectorTester xv01 #xv01))
(test-at-ifAbsent (xv:name: XVectorTester xv02 #xv02))
(test-at-ifAbsent (xv:name: XVectorTester xv03 #xv03))
(test-at-ifAbsent (xv:name: XVectorTester xv04 #xv04))
(test-at-ifAbsent (xv:name: XVectorTester xv05 #xv05))
(test-at-ifAbsent (xv:name: XVectorTester xv06 #xv06))
(test-at-ifAbsent (xv:name: XVectorTester xv07 #xv07))
(test-at-ifAbsent (xv:name: XVectorTester xv08 #xv08))
(test-at-ifAbsent (xv:name: XVectorTester xv09 #xv09))
(test-at-ifAbsent (xv:name: XVectorTester xv10 #xv10))
(test-at-ifAbsent (xv:name: XVectorTester xv11 #xv11))
(test-at-ifAbsent (xv:name: XVectorTester xv12 #xv12))
(test-at-ifAbsent (xv:name: XVectorTester xv13 #xv13))

(begin (print s-newline) (println ###########) unit)

;; test-B-do:.smt
(test-do (xv:name: XVectorTester xv01 #xv01))
(test-do (xv:name: XVectorTester xv02 #xv02))
(test-do (xv:name: XVectorTester xv03 #xv03))
(test-do (xv:name: XVectorTester xv04 #xv04))
(test-do (xv:name: XVectorTester xv05 #xv05))
(test-do (xv:name: XVectorTester xv06 #xv06))
(test-do (xv:name: XVectorTester xv07 #xv07))
(test-do (xv:name: XVectorTester xv08 #xv08))
(test-do (xv:name: XVectorTester xv09 #xv09))
(test-do (xv:name: XVectorTester xv10 #xv10))
(test-do (xv:name: XVectorTester xv11 #xv11))
(test-do (xv:name: XVectorTester xv12 #xv12))
(test-do (xv:name: XVectorTester xv13 #xv13))

(begin (print s-newline) (println ###########) unit)

;; test-C-sum:.smt
(test-sum (xv:name: XVectorTester xv01 #xv01))
(test-sum (xv:name: XVectorTester xv02 #xv02))
(test-sum (xv:name: XVectorTester xv03 #xv03))
(test-sum (xv:name: XVectorTester xv04 #xv04))
(test-sum (xv:name: XVectorTester xv05 #xv05))
(test-sum (xv:name: XVectorTester xv06 #xv06))
(test-sum (xv:name: XVectorTester xv07 #xv07))
(test-sum (xv:name: XVectorTester xv08 #xv08))
(test-sum (xv:name: XVectorTester xv09 #xv09))
(test-sum (xv:name: XVectorTester xv10 #xv10))
(test-sum (xv:name: XVectorTester xv11 #xv11))
(test-sum (xv:name: XVectorTester xv12 #xv12))
(test-sum (xv:name: XVectorTester xv13 #xv13))

(begin (print s-newline) (println ###########) unit)

;; test-D-product:.smt
(test-product (xv:name: XVectorTester xv01 #xv01))
(test-product (xv:name: XVectorTester xv02 #xv02))
(test-product (xv:name: XVectorTester xv03 #xv03))
(test-product (xv:name: XVectorTester xv04 #xv04))
(test-product (xv:name: XVectorTester xv05 #xv05))
(test-product (xv:name: XVectorTester xv06 #xv06))
(test-product (xv:name: XVectorTester xv07 #xv07))
(test-product (xv:name: XVectorTester xv08 #xv08))
(test-product (xv:name: XVectorTester xv09 #xv09))
(test-product (xv:name: XVectorTester xv10 #xv10))
(test-product (xv:name: XVectorTester xv11 #xv11))
(test-product (xv:name: XVectorTester xv12 #xv12))
(test-product (xv:name: XVectorTester xv13 #xv13))

(begin (print s-newline) (println ###########) unit)

;; test-E-min:.smt
(test-min (xv:name: XVectorTester xv01 #xv01))
(test-min (xv:name: XVectorTester xv02 #xv02))
(test-min (xv:name: XVectorTester xv03 #xv03))
(test-min (xv:name: XVectorTester xv04 #xv04))
(test-min (xv:name: XVectorTester xv05 #xv05))
(test-min (xv:name: XVectorTester xv06 #xv06))
(test-min (xv:name: XVectorTester xv07 #xv07))
(test-min (xv:name: XVectorTester xv08 #xv08))
(test-min (xv:name: XVectorTester xv09 #xv09))
(test-min (xv:name: XVectorTester xv10 #xv10))
(test-min (xv:name: XVectorTester xv11 #xv11))
(test-min (xv:name: XVectorTester xv12 #xv12))
(test-min (xv:name: XVectorTester xv13 #xv13))

(begin (print s-newline) (println ###########) unit)

;; test-F-max:.smt
(test-max (xv:name: XVectorTester xv01 #xv01))
(test-max (xv:name: XVectorTester xv02 #xv02))
(test-max (xv:name: XVectorTester xv03 #xv03))
(test-max (xv:name: XVectorTester xv04 #xv04))
(test-max (xv:name: XVectorTester xv05 #xv05))
(test-max (xv:name: XVectorTester xv06 #xv06))
(test-max (xv:name: XVectorTester xv07 #xv07))
(test-max (xv:name: XVectorTester xv08 #xv08))
(test-max (xv:name: XVectorTester xv09 #xv09))
(test-max (xv:name: XVectorTester xv10 #xv10))
(test-max (xv:name: XVectorTester xv11 #xv11))
(test-max (xv:name: XVectorTester xv12 #xv12))
(test-max (xv:name: XVectorTester xv13 #xv13))

(begin (print s-newline) (println ###########) unit)

;; test-G-eq:.smt
(test-eq:: (xv:name: XVectorTester xv01 #xv01) xvs ns)
(test-eq:: (xv:name: XVectorTester xv02 #xv02) xvs ns)
(test-eq:: (xv:name: XVectorTester xv03 #xv03) xvs ns)
(test-eq:: (xv:name: XVectorTester xv04 #xv04) xvs ns)
(test-eq:: (xv:name: XVectorTester xv05 #xv05) xvs ns)
(test-eq:: (xv:name: XVectorTester xv06 #xv06) xvs ns)
(test-eq:: (xv:name: XVectorTester xv07 #xv07) xvs ns)
(test-eq:: (xv:name: XVectorTester xv08 #xv08) xvs ns)
(test-eq:: (xv:name: XVectorTester xv09 #xv09) xvs ns)
(test-eq:: (xv:name: XVectorTester xv10 #xv10) xvs ns)
(test-eq:: (xv:name: XVectorTester xv11 #xv11) xvs ns)
(test-eq:: (xv:name: XVectorTester xv12 #xv12) xvs ns)
(test-eq:: (xv:name: XVectorTester xv13 #xv13) xvs ns)

(begin (print s-newline) (println ###########) unit)

;; test-H-lt:.smt
(test-lt:: (xv:name: XVectorTester xv01 #xv01) xvs ns)
(test-lt:: (xv:name: XVectorTester xv02 #xv02) xvs ns)
(test-lt:: (xv:name: XVectorTester xv03 #xv03) xvs ns)
(test-lt:: (xv:name: XVectorTester xv04 #xv04) xvs ns)
(test-lt:: (xv:name: XVectorTester xv05 #xv05) xvs ns)
(test-lt:: (xv:name: XVectorTester xv06 #xv06) xvs ns)
(test-lt:: (xv:name: XVectorTester xv07 #xv07) xvs ns)
(test-lt:: (xv:name: XVectorTester xv08 #xv08) xvs ns)
(test-lt:: (xv:name: XVectorTester xv09 #xv09) xvs ns)
(test-lt:: (xv:name: XVectorTester xv10 #xv10) xvs ns)
(test-lt:: (xv:name: XVectorTester xv11 #xv11) xvs ns)
(test-lt:: (xv:name: XVectorTester xv12 #xv12) xvs ns)
(test-lt:: (xv:name: XVectorTester xv13 #xv13) xvs ns)

(begin (print s-newline) (println ###########) unit)

;; test-I-fromIndex:toIndex:.smt
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

(begin (print s-newline) (println ###########) unit)

;; test-Ja-init-ConcatXVector.smt
(val cxv01 unit)
(begin (set cxv01 (withXV1:withXV2: ConcatXVector xv01 xv01)) (add: xvs cxv01) (add: ns #cxv01) unit)
(val cxv02 unit)
(begin (set cxv02 (withXV1:withXV2: ConcatXVector xv04 xv07)) (add: xvs cxv02) (add: ns #cxv02) unit)
(val cxv03 unit)
(begin (set cxv03 (withXV1:withXV2: ConcatXVector xv06 xv03)) (add: xvs cxv03) (add: ns #cxv03) unit)

(begin (print s-newline) (println ###########) unit)

;; test-Jb-init-RepeatXVector.smt
(val mxv01 unit)
(begin (set mxv01 (withXV:withN: RepeatXVector xv01 10)) (add: xvs mxv01) (add: ns #mxv01) unit)
(val mxv02 unit)
(begin (set mxv02 (withXV:withN: RepeatXVector xv04 0)) (add: xvs mxv02) (add: ns #mxv02) unit)
(val mxv03 unit)
(begin (set mxv03 (withXV:withN: RepeatXVector xv04 10)) (add: xvs mxv03) (add: ns #mxv03) unit)
(val mxv04 unit)
(begin (set mxv04 (withXV:withN: RepeatXVector xv07 100)) (add: xvs mxv04) (add: ns #mxv04) unit)

(begin (print s-newline) (println ###########) unit)

;; test-Jc-init-ReverseXVector.smt
(val rxv01 unit)
(begin (set rxv01 (withXV: ReverseXVector xv01)) (add: xvs rxv01) (add: ns #rxv01) unit)
(val rxv02 unit)
(begin (set rxv02 (withXV: ReverseXVector xv02)) (add: xvs rxv02) (add: ns #rxv02) unit)
(val rxv03 unit)
(begin (set rxv03 (withXV: ReverseXVector xv03)) (add: xvs rxv03) (add: ns #rxv03) unit)
(val rxv04 unit)
(begin (set rxv04 (withXV: ReverseXVector xv04)) (add: xvs rxv04) (add: ns #rxv04) unit)
(val rxv05 unit)
(begin (set rxv05 (withXV: ReverseXVector xv07)) (add: xvs rxv05) (add: ns #rxv05) unit)

(begin (print s-newline) (println ###########) unit)

;; test-Jd-init-SwizzleXVector.smt
(val sxv01 unit)
(begin (set sxv01 (withXV1:withXV2: SwizzleXVector xv01 xv01)) (add: xvs sxv01) (add: ns #sxv01) unit)
(val sxv02 unit)
(begin (set sxv02 (withXV1:withXV2: SwizzleXVector xv01 xv04)) (add: xvs sxv02) (add: ns #sxv02) unit)
(val sxv03 unit)
(begin (set sxv03 (withXV1:withXV2: SwizzleXVector xv04 xv01)) (add: xvs sxv03) (add: ns #sxv03) unit)
(val sxv04 unit)
(begin (set sxv04 (withXV1:withXV2: SwizzleXVector xv03 xv03)) (add: xvs sxv04) (add: ns #sxv04) unit)
(val sxv05 unit)
(begin (set sxv05 (withXV1:withXV2: SwizzleXVector xv03 xv04)) (add: xvs sxv05) (add: ns #sxv05) unit)
(val sxv06 unit)
(begin (set sxv06 (withXV1:withXV2: SwizzleXVector xv04 xv03)) (add: xvs sxv06) (add: ns #sxv06) unit)
(val sxv07 unit)
(begin (set sxv07 (withXV1:withXV2: SwizzleXVector xv04 xv04)) (add: xvs sxv07) (add: ns #sxv07) unit)

(begin (print s-newline) (println ###########) unit)

;; test-Je-init-BlockXVector.smt
(val bxv01 unit)
(begin (set bxv01 (withN:withBlock: BlockXVector 100 (new BlockFn1))) (add: xvs bxv01) (add: ns #bxv01) unit)
(val bxv02 unit)
(begin (set bxv02 (withN:withBlock: BlockXVector 100 (new BlockFn2))) (add: xvs bxv02) (add: ns #bxv02) unit)

(begin (print s-newline) (println ###########) unit)

;; test-Ka-debug-ConcatXVector.smt
(test-debug (xv:name:-no-init XVectorTester cxv01 #cxv01))
(test-debug (xv:name:-no-init XVectorTester cxv02 #cxv02))
(test-debug (xv:name:-no-init XVectorTester cxv03 #cxv03))

(begin (print s-newline) (println ###########) unit)

;; test-Kb-debug-RepeatXVector.smt
(test-debug (xv:name:-no-init XVectorTester mxv01 #mxv01))
(test-debug (xv:name:-no-init XVectorTester mxv02 #mxv02))
(test-debug (xv:name:-no-init XVectorTester mxv03 #mxv03))
(test-debug (xv:name:-no-init XVectorTester mxv04 #mxv04))

(begin (print s-newline) (println ###########) unit)

;; test-Kc-debug-ReverseXVector.smt
(test-debug (xv:name:-no-init XVectorTester rxv01 #rxv01))
(test-debug (xv:name:-no-init XVectorTester rxv02 #rxv02))
(test-debug (xv:name:-no-init XVectorTester rxv03 #rxv03))
(test-debug (xv:name:-no-init XVectorTester rxv04 #rxv04))
(test-debug (xv:name:-no-init XVectorTester rxv05 #rxv05))

(begin (print s-newline) (println ###########) unit)

;; test-Kd-debug-SwizzleXVector.smt
(test-debug (xv:name:-no-init XVectorTester sxv01 #sxv01))
(test-debug (xv:name:-no-init XVectorTester sxv02 #sxv02))
(test-debug (xv:name:-no-init XVectorTester sxv03 #sxv03))
(test-debug (xv:name:-no-init XVectorTester sxv04 #sxv04))
(test-debug (xv:name:-no-init XVectorTester sxv05 #sxv05))
(test-debug (xv:name:-no-init XVectorTester sxv06 #sxv06))
(test-debug (xv:name:-no-init XVectorTester sxv07 #sxv07))

(begin (print s-newline) (println ###########) unit)

;; test-Ke-debug-BlockXVector.smt
(test-debug (xv:name:-no-init XVectorTester bxv01 #bxv01))
(test-debug (xv:name:-no-init XVectorTester bxv02 #bxv02))

(begin (print s-newline) (println ###########) unit)

;; test-La-size-ConcatXVector.smt
(test-size (xv:name:-no-init XVectorTester cxv01 #cxv01))
(test-size (xv:name:-no-init XVectorTester cxv02 #cxv02))
(test-size (xv:name:-no-init XVectorTester cxv03 #cxv03))

(begin (print s-newline) (println ###########) unit)

;; test-Lb-size-RepeatXVector.smt
(test-size (xv:name:-no-init XVectorTester mxv01 #mxv01))
(test-size (xv:name:-no-init XVectorTester mxv02 #mxv02))
(test-size (xv:name:-no-init XVectorTester mxv03 #mxv03))
(test-size (xv:name:-no-init XVectorTester mxv04 #mxv04))

(begin (print s-newline) (println ###########) unit)

;; test-Lc-size-ReverseXVector.smt
(test-size (xv:name:-no-init XVectorTester rxv01 #rxv01))
(test-size (xv:name:-no-init XVectorTester rxv02 #rxv02))
(test-size (xv:name:-no-init XVectorTester rxv03 #rxv03))
(test-size (xv:name:-no-init XVectorTester rxv04 #rxv04))
(test-size (xv:name:-no-init XVectorTester rxv05 #rxv05))

(begin (print s-newline) (println ###########) unit)

;; test-Ld-size-SwizzleXVector.smt
(test-size (xv:name:-no-init XVectorTester sxv01 #sxv01))
(test-size (xv:name:-no-init XVectorTester sxv02 #sxv02))
(test-size (xv:name:-no-init XVectorTester sxv03 #sxv03))
(test-size (xv:name:-no-init XVectorTester sxv04 #sxv04))
(test-size (xv:name:-no-init XVectorTester sxv05 #sxv05))
(test-size (xv:name:-no-init XVectorTester sxv06 #sxv06))
(test-size (xv:name:-no-init XVectorTester sxv07 #sxv07))

(begin (print s-newline) (println ###########) unit)

;; test-Le-size-BlockXVector.smt
(test-size (xv:name:-no-init XVectorTester bxv01 #bxv01))
(test-size (xv:name:-no-init XVectorTester bxv02 #bxv02))

(begin (print s-newline) (println ###########) unit)

;; test-Ma-elem:-ConcatXVector.smt
(test-elem (xv:name:-no-init XVectorTester cxv01 #cxv01))
(test-elem (xv:name:-no-init XVectorTester cxv02 #cxv02))
(test-elem (xv:name:-no-init XVectorTester cxv03 #cxv03))

(begin (print s-newline) (println ###########) unit)

;; test-Mb-elem:-RepeatXVector.smt
(test-elem (xv:name:-no-init XVectorTester mxv01 #mxv01))
(test-elem (xv:name:-no-init XVectorTester mxv02 #mxv02))
(test-elem (xv:name:-no-init XVectorTester mxv03 #mxv03))
(test-elem (xv:name:-no-init XVectorTester mxv04 #mxv04))

(begin (print s-newline) (println ###########) unit)

;; test-Mc-elem:-ReverseXVector.smt
(test-elem (xv:name:-no-init XVectorTester rxv01 #rxv01))
(test-elem (xv:name:-no-init XVectorTester rxv02 #rxv02))
(test-elem (xv:name:-no-init XVectorTester rxv03 #rxv03))
(test-elem (xv:name:-no-init XVectorTester rxv04 #rxv04))
(test-elem (xv:name:-no-init XVectorTester rxv05 #rxv05))

(begin (print s-newline) (println ###########) unit)

;; test-Md-elem:-SwizzleXVector.smt
(test-elem (xv:name:-no-init XVectorTester sxv01 #sxv01))
(test-elem (xv:name:-no-init XVectorTester sxv02 #sxv02))
(test-elem (xv:name:-no-init XVectorTester sxv03 #sxv03))
(test-elem (xv:name:-no-init XVectorTester sxv04 #sxv04))
(test-elem (xv:name:-no-init XVectorTester sxv05 #sxv05))
(test-elem (xv:name:-no-init XVectorTester sxv06 #sxv06))
(test-elem (xv:name:-no-init XVectorTester sxv07 #sxv07))

(begin (print s-newline) (println ###########) unit)

;; test-Me-elem:-BlockXVector.smt
(test-elem (xv:name:-no-init XVectorTester bxv01 #bxv01))
(test-elem (xv:name:-no-init XVectorTester bxv02 #bxv02))

(begin (print s-newline) (println ###########) unit)

;; test-Na-all::-ConcatXVector.smt
(test-all:: (xv:name: XVectorTester cxv01 #cxv01) xvs ns)
(test-all:: (xv:name: XVectorTester cxv02 #cxv02) xvs ns)
(test-all:: (xv:name: XVectorTester cxv03 #cxv03) xvs ns)

(begin (print s-newline) (println ###########) unit)

;; test-Nb-all::-RepeatXVector.smt
(test-all:: (xv:name: XVectorTester mxv01 #mxv01) xvs ns)
(test-all:: (xv:name: XVectorTester mxv02 #mxv02) xvs ns)
(test-all:: (xv:name: XVectorTester mxv03 #mxv03) xvs ns)
(test-all:: (xv:name: XVectorTester mxv04 #mxv04) xvs ns)

(begin (print s-newline) (println ###########) unit)

;; test-Nc-all::-ReverseXVector.smt
(test-all:: (xv:name: XVectorTester rxv01 #rxv01) xvs ns)
(test-all:: (xv:name: XVectorTester rxv02 #rxv02) xvs ns)
(test-all:: (xv:name: XVectorTester rxv03 #rxv03) xvs ns)
(test-all:: (xv:name: XVectorTester rxv04 #rxv04) xvs ns)
(test-all:: (xv:name: XVectorTester rxv05 #rxv05) xvs ns)

(begin (print s-newline) (println ###########) unit)

;; test-Nd-all::-SwizzleXVector.smt
(test-all:: (xv:name: XVectorTester sxv01 #sxv01) xvs ns)
(test-all:: (xv:name: XVectorTester sxv02 #sxv02) xvs ns)
(test-all:: (xv:name: XVectorTester sxv03 #sxv03) xvs ns)
(test-all:: (xv:name: XVectorTester sxv04 #sxv04) xvs ns)
(test-all:: (xv:name: XVectorTester sxv05 #sxv05) xvs ns)
(test-all:: (xv:name: XVectorTester sxv06 #sxv06) xvs ns)
(test-all:: (xv:name: XVectorTester sxv07 #sxv07) xvs ns)

(begin (print s-newline) (println ###########) unit)

;; test-Ne-all::-BlockXVector.smt
(test-all:: (xv:name: XVectorTester bxv01 #bxv01) xvs ns)
(test-all:: (xv:name: XVectorTester bxv02 #bxv02) xvs ns)

(begin (print s-newline) (println ###########) unit)

;; test-Z-misc.smt
(class XVectorTesterMisc Object
  ()
  (class-method testXV:testName: (xv name) (testXV:testName:doProduct: self xv name true))
  (class-method testXV:testName:doProduct: (xv name doProduct) (locals tmp size smallSize verySmallSize allMag allNum allInt allFrac someFrac allFloat someFloat vals fromIndices toIndices)
    (set vals (new: Array 7))
    (at:put: vals 1 nil)
    (at:put: vals 2 true)
    (at:put: vals 3 false)
    (at:put: vals 4 0)
    (at:put: vals 5 1)
    (at:put: vals 6 2)
    (at:put: vals 6 42)
    (set fromIndices #(1 1 1 1 2 2 -1 -2 -3 -5 -2 -4 -1 -2 -3 -4 -5))
    (set toIndices   #(1 2 3 5 2 4 -1 -1 -1 -1 -2 -2  1  2  3  4  5))
    (print #Testing) (print s-space) (println name)
    (print s-lparen) (print #debug) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (debug xv) (print s-newline)
    (print s-lparen) (print #size) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (size xv))
    (set size (size xv))
    (set smallSize (< size (raisedToInteger: 2 12)))
    (set verySmallSize (< size (raisedToInteger: 2 8)))
    (ifTrue: (< size 20) {(print s-lparen) (print #print) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println xv)})
    (do: #(1 2 3 4 5) (block (i)
      (set tmp i)
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print name) (print s-space) (print tmp) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))))
    ; (do: #(0 1 2 3 4 5 6 7 8 9 26 27 28 29 30) (block (i)
    (do: #(0 30) (block (i)
      (set tmp (- (raisedToInteger: 2 i) 1))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))
      (set tmp (raisedToInteger: 2 i))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))
      (set tmp (+ (raisedToInteger: 2 i) 1))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))))
    (do: #(5 4 3 2 1) (block (i)
      (set tmp (negated i))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))))
    ; (do: #(30 29 28 27 26 9 8 7 6 5 4 3 2 1 0) (block (i)
    (do: #(30 0) (block (i)
      (set tmp (negated (+ (raisedToInteger: 2 i) 1)))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))
      (set tmp (negated (raisedToInteger: 2 i)))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))
      (set tmp (negated (- (raisedToInteger: 2 i) 1)))
      (print s-lparen) (print #at:ifAbsent:) (print s-space) (print name) (print s-space) (print tmp) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (at:ifAbsent: xv tmp {nil}))))
    (ifTrue: smallSize {
      (set allMag (inject:into: xv true (block (x allMag) (& allMag (isKindOf: x Magnitude)))))
      (print s-lparen) (print #allMag) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println allMag)
      (set allNum (inject:into: xv true (block (x allNum) (& allNum (isKindOf: x Number)))))
      (print s-lparen) (print #allNum) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println allNum)
      (set allInt (inject:into: xv true (block (x allInt) (& allInt (isKindOf: x Integer)))))
      (print s-lparen) (print #allInt) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println allInt)
      (set allFrac (inject:into: xv true (block (x allFrac) (& allFrac (isKindOf: x Fraction)))))
      (print s-lparen) (print #allFrac) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println allFrac)
      (set someFrac (inject:into: xv false (block (x someFrac) (| someFrac (isKindOf: x Fraction)))))
      (print s-lparen) (print #someFrac) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println someFrac)
      (set allFloat (inject:into: xv true (block (x allFloat) (& allFloat (isKindOf: x Float)))))
      (print s-lparen) (print #allFloat) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println allFloat)
      (set someFloat (inject:into: xv false (block (x someFloat) (| someFloat (isKindOf: x Float)))))
      (print s-lparen) (print #someFloat) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println someFloat)
      (ifTrue: (& allMag (> size 0)) {(print s-lparen) (print #min) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (min xv))})
      (ifTrue: (& allMag (> size 0)) {(print s-lparen) (print #max) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (max xv))})
      (ifTrue: (& allNum verySmallSize) {(print s-lparen) (print #sum) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (sum xv))})
      (ifTrue: (& doProduct (& allNum verySmallSize)) {(print s-lparen) (print #product) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (product xv))})
      (ifFalse: (| someFrac someFloat) {(do: vals (block (x)
        (print s-lparen) (print #includes:) (print s-space) (print name) (print s-space) (print x) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (includes: xv x))
        (print s-lparen) (print #occurrencesOf:) (print s-space) (print name) (print s-space) (print x) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (occurrencesOf: xv x))))})
      (ifTrue: allNum {
        (print s-lparen) (print #detect:ifNone:) (print s-space) (print name) (print s-space) (print #negative) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (detect:ifNone: xv (block (x) (negative x)) {nil}))
        (print s-lparen) (print #detect:ifNone:) (print s-space) (print name) (print s-space) (print #positive) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (detect:ifNone: xv (block (x) (positive x)) {nil}))})
      (print s-lparen) (print #=) (print s-space) (print name) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (= xv xv))
      (ifTrue: allMag {
        (print s-lparen) (print #<) (print s-space) (print name) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (< xv xv))
        (print s-lparen) (print #<=) (print s-space) (print name) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (<= xv xv))
        (print s-lparen) (print #>) (print s-space) (print name) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (> xv xv))
        (print s-lparen) (print #>=) (print s-space) (print name) (print s-space) (print name) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (>= xv xv))})})
    (do: vals (block (x)
      (print s-lparen) (print #=) (print s-space) (print name) (print s-space) (print x) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (= xv x))))
    (ifTrue: (> size 5) {
      (set tmp 1)
      (whileTrue: {(<= tmp (size fromIndices))} {
        (print s-lparen) (print #fromIndex:toIndex:) (print s-space) (print name) (print s-space) (print (at: fromIndices tmp)) (print s-space) (print (at: toIndices tmp)) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (fromIndex:toIndex: xv (at: fromIndices tmp) (at: toIndices tmp)))
        (set tmp (+ tmp 1))})})
    unit
  )
  (class-method testXV1:testName1:testXV2:testName2: (xv1 name1 xv2 name2) (locals tmp size1 size2)
    (ifTrue: (| (< (size xv1) (raisedToInteger: 2 10)) (< (size xv2) (raisedToInteger: 2 10))) {
      (print #Testing) (print s-space) (print name1) (print s-space) (println name2)
      (print s-lparen) (print #=) (print s-space) (print name1) (print s-space) (print name2) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (= xv1 xv2))
      (print s-lparen) (print #<) (print s-space) (print name1) (print s-space) (print name2) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (< xv1 xv2))
      (print s-lparen) (print #<=) (print s-space) (print name1) (print s-space) (print name2) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (<= xv1 xv2))
      (print s-lparen) (print #>) (print s-space) (print name1) (print s-space) (print name2) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (> xv1 xv2))
      (print s-lparen) (print #>=) (print s-space) (print name1) (print s-space) (print name2) (print s-rparen) (print s-space) (print #=>) (print s-space) (println (>= xv1 xv2))}))
  (class-method testXVs:testNs: (xvs ns) (locals i j)
    (set i 1)
    (whileTrue: {(<= i (size xvs))} {
      (set j 1)
      (whileTrue: {(<= j (size xvs))} {
        (testXV1:testName1:testXV2:testName2: self (at: xvs i) (at: ns i) (at: xvs j) (at: ns j))
        (set j (+ j 1))})
      (set i (+ i 1))})
    unit)
)

(val xvs unit)
(begin (set xvs (new List)) unit)
(val ns unit)
(begin (set ns (new List)) unit)

(begin (print s-newline) (println ###########) unit)

(val xv01 unit)
(begin (set xv01 (withArr: ArrayXVector #(1 2 3 4 5 6))) (add: xvs xv01) (add: ns #xv01) unit)
(testXV:testName: XVectorTesterMisc xv01 #xv01)

(begin (print s-newline) (println ###########) unit)

(val xv02 unit)
(begin (set xv02 (withArr: ArrayXVector #(-6 -5 -5 -4 -2 -1))) (add: xvs xv02) (add: ns #xv02) unit)
(testXV:testName: XVectorTesterMisc xv02 #xv02)

(begin (print s-newline) (println ###########) unit)

(val xv03 unit)
(begin (set xv03 (withXV1:withXV2: ConcatXVector xv01 xv02)) (add: xvs xv03) (add: ns #xv03) unit)
(testXV:testName: XVectorTesterMisc xv03 #xv03)

(begin (print s-newline) (println ###########) unit)

(val xv04 unit)
(begin (set xv04 (withXV:withN: RepeatXVector xv01 3)) (add: xvs xv04) (add: ns #xv04) unit)
(testXV:testName: XVectorTesterMisc xv04 #xv04)

(begin (print s-newline) (println ###########) unit)

(val xv05 unit)
(begin (set xv05 (withXV:withN: RepeatXVector xv01 0)) (add: xvs xv05) (add: ns #xv05) unit)
(testXV:testName: XVectorTesterMisc xv05 #xv05)

(begin (print s-newline) (println ###########) unit)

(val xv06 unit)
(begin (set xv06 (withXV:withN: RepeatXVector xv03 1000)) (add: xvs xv06) (add: ns #xv06) unit)
(testXV:testName: XVectorTesterMisc xv06 #xv06)

(begin (print s-newline) (println ###########) unit)

(val xv07 unit)
(begin (set xv07 (withXV: ReverseXVector xv01)) (add: xvs xv07) (add: ns #xv07) unit)
(testXV:testName: XVectorTesterMisc xv07 #xv07)

(begin (print s-newline) (println ###########) unit)

(val xv08 unit)
(begin (set xv08 (withXV: ReverseXVector xv03)) (add: xvs xv08) (add: ns #xv08) unit)
(testXV:testName: XVectorTesterMisc xv08 #xv08)

(begin (print s-newline) (println ###########) unit)

(val xv09 unit)
(begin (set xv09 (withXV: ReverseXVector xv05)) (add: xvs xv09) (add: ns #xv09) unit)
(testXV:testName: XVectorTesterMisc xv09 #xv09)

(begin (print s-newline) (println ###########) unit)

(val xv10 unit)
(begin (set xv10 (withXV: ReverseXVector xv06)) (add: xvs xv10) (add: ns #xv10) unit)
(testXV:testName: XVectorTesterMisc xv10 #xv10)

(begin (print s-newline) (println ###########) unit)

(val xv11 unit)
(begin (set xv11 (withXV: ReverseXVector xv03)) (add: xvs xv11) (add: ns #xv11) unit)
(testXV:testName: XVectorTesterMisc xv11 #xv11)

(begin (print s-newline) (println ###########) unit)

(val xv12 unit)
(begin (set xv12 (withXV1:withXV2: SwizzleXVector xv01 xv02)) (add: xvs xv12) (add: ns #xv12) unit)
(testXV:testName: XVectorTesterMisc xv12 #xv12)

(begin (print s-newline) (println ###########) unit)

(val xv13 unit)
(begin (set xv13 (withXV1:withXV2: SwizzleXVector xv01 xv03)) (add: xvs xv13) (add: ns #xv13) unit)
(testXV:testName: XVectorTesterMisc xv13 #xv13)

(begin (print s-newline) (println ###########) unit)

(val xv14 unit)
(begin (set xv14 (withXV1:withXV2: SwizzleXVector xv03 xv01)) (add: xvs xv14) (add: ns #xv14) unit)
(testXV:testName: XVectorTesterMisc xv14 #xv14)

(begin (print s-newline) (println ###########) unit)

(val xv15 unit)
(begin (set xv15 (withXV1:withXV2: SwizzleXVector xv04 xv05)) (add: xvs xv15) (add: ns #xv15) unit)
(testXV:testName: XVectorTesterMisc xv15 #xv15)

(begin (print s-newline) (println ###########) unit)

(val xv16 unit)
(begin (set xv16 (withXV1:withXV2: SwizzleXVector xv03 xv01)) (add: xvs xv16) (add: ns #xv16) unit)
(testXV:testName: XVectorTesterMisc xv16 #xv16)

(begin (print s-newline) (println ###########) unit)

(val xv17 unit)
(begin (set xv17 (withXV1:withXV2: SwizzleXVector xv10 xv06)) (add: xvs xv17) (add: ns #xv17) unit)
(testXV:testName: XVectorTesterMisc xv17 #xv17)

(begin (print s-newline) (println ###########) unit)

(val xv18 unit)
(begin (set xv18 (withN:withBlock: BlockXVector 100 (new BlockFn1))) (add: xvs xv18) (add: ns #xv18) unit)
(testXV:testName:doProduct: XVectorTesterMisc xv18 #xv18 false)

(begin (print s-newline) (println ###########) unit)

(val xv19 unit)
(begin (set xv19 (withN:withBlock: BlockXVector 100 (new BlockFn2))) (add: xvs xv19) (add: ns #xv19) unit)
(testXV:testName:doProduct: XVectorTesterMisc xv19 #xv19 false)

(begin (print s-newline) (println ###########) unit)

(val xv20 unit)
(begin (set xv20 (+ (reverse (* xv08 10)) (+ (+ xv11 (reverse xv13)) (* xv19 10)))) (add: xvs xv20) (add: ns #xv20) unit)
(testXV:testName: XVectorTesterMisc xv20 #xv20)

(begin (print s-newline) (println ###########) unit)

(testXVs:testNs: XVectorTesterMisc xvs ns)

(begin (print s-newline) (println ###########) unit)

(val xv21 unit)
(begin (set xv21 (withN:withBlock: BlockXVector 10 (new BlockFn3))) unit)
(testXV:testName: XVectorTesterMisc xv21 #xv21)

(begin (print s-newline) (println ###########) unit)

(val xv22 unit)
(begin (set xv22 (withN:withBlock: BlockXVector 15 (new BlockFn4))) unit)
(testXV:testName: XVectorTesterMisc xv22 #xv22)

(begin (print s-newline) (println ###########) unit)

(begin (print s-newline) (println ###########) unit)

