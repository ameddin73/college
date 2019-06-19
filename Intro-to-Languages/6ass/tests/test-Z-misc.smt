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
