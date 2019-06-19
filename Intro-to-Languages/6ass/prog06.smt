;; Name: Alex Meddin 
;; Time spent on assignment: 
;; Collaborators: 



(class XVector Object
  () ; abstract class

  ;;
  ;; Display methods
  ;;
  (method print ()
    (print #<<)
    (do: self (block (x) (print s-space) (print x)))
    (print s-space)
    (print #>>)
    self)
  (method debug () (subclassResponsibility self))

  ;;
  ;; Observer methods
  ;;
  (method isEmpty () (= (size self) 0))
  (method size () (subclassResponsibility self))
  (method at: (index) (at:ifAbsent: self index {(error: self #index-out-of-bounds)}))
  (method at:ifAbsent: (index exnBlock) (if (not (= 0 index))
    {(if (< index 0)
        {(if (<= (abs index) (size self))
            {(elem: self (+ (+ 1 index) (size self)))}
            {(value exnBlock)})} 
        {(if (<= index (size self))
            {(elem: self index)} 
            {(value exnBlock)})})}
    {(value exnBlock)}))
  (method elem: (index) (subclassResponsibility self))

  ;; copied from Collection implementation; uses do:
  (method occurrencesOf: (anObject) (locals temp)
    (set temp 0)
    (do: self (block (x)
       (ifTrue: (= x anObject) {(set temp (+ temp 1))})))
    temp)
  ;; copied from Collection implementation
  (method includes: (anObject) (< 0 (occurrencesOf: self anObject)))
  ;; copied from Collection implementation
  (method detect: (aBlock) 
    (detect:ifNone: self aBlock {(error: self #no-object-detected)}))
  ;; copied from Collection implementation; uses do:
  (method detect:ifNone: (aBlock exnBlock) (locals answer searching)
    (set searching true)
    (do: self (block (x)
      (ifTrue: (and: searching {(value aBlock x)})
         {(set searching false) (set answer x)})))
    (if searching exnBlock {answer}))

  (method sum () (locals adder index)
    (if (> (size self) 1)
        {(set adder (at: self 1))
            (set index 2)
            (timesRepeat: (- (size self) 1)
                {(set adder (+ (at: self index) adder)) 
                (set index (+ index 1))})
        adder}
        {(if (= 0 (size self))
            {0} 
            {(at: self 1)})}))
  (method product () (locals mult index)
    (if (> (size self) 1)
        {(set mult (at: self 1))
            (set index 2)
            (timesRepeat: (- (size self) 1)
                {(set mult (* (at: self index) mult)) 
                (set index (+ index 1))})
        mult}
        {(if (= 0 (size self))
            {1} 
            {(at: self 1)})}))
  (method min () (locals min index)
    (if (> (size self) 1)
        {(set min (at: self 1))
        (set index 2)
        (timesRepeat: (- (size self) 1)
            {(ifTrue: (< (at: self index) min)
                {(set min (at: self index))})
            (set index (+ index 1))})
        min}
        {(if (= 0 (size self))
            {(error: self #min-of-empty)} 
            {(at: self 1)})}))
  (method max () (locals max index)
    (if (> (size self) 1)
        {(set max (at: self 1))
        (set index 2)
        (timesRepeat: (- (size self) 1)
            {(ifTrue: (> (at: self index) max)
                {(set max (at: self index))})
            (set index (+ index 1))})
        max}
        {(if (= 0 (size self))
            {(error: self #max-of-empty)} 
            {(at: self 1)})}))

  ;;
  ;; Iterator methods
  ;;
  (method do: (aBlock) (locals index)
    (set index 1)
    (timesRepeat: (size self)
        {(value aBlock (at: self index))
        (set index (+ index 1))}))

  ;; copied from Collection implementation; uses do:
  (method inject:into: (thisValue binaryBlock)
    (do: self (block (x) (set thisValue (value binaryBlock x thisValue))))
    thisValue)

  ;;
  ;; Comparison methods
  ;;
  (method = (anObject) (locals ret index)
    (set ret true)
    (set index 1)
    (if (isKindOf: anObject XVector)    
        {(if (not (= (size anObject) 0))
            {(if (= (size anObject) (size self))
                {(timesRepeat: (size self)
                    {(ifFalse: (= (at: anObject index) (at: self index))
                        {(set ret false)})
                    (set index (+ index 1))})
                ret}
                {false})}
            {(if (= (size self) 0) {true} {false})})}
        {false}))
  (method < (anXVector) (locals ret index)
    (set ret true)
    (set index 1)
    (if (isKindOf: anXVector XVector)    
        {(if (not (= (size anXVector) 0))
            {(if (= (size anXVector) (size self))
                {(timesRepeat: (size self)
                    {(ifFalse: (> (at: anXVector index) (at: self index))
                        {(set ret false)})
                    (set index (+ index 1))})
                    ret}
                {(if (> (size anXVector) (size self))
                    {(timesRepeat: (size self)
                        {(ifFalse: (>= (at: anXVector index) (at: self index))
                            {(set ret false)})
                        (set index (+ index 1))})
                        ret}
                    {false})})}
            {false})}
        {false}))

  ;; copied from Magnitude implementation; uses <
  (method >  (anXVector) (< anXVector self))
  (method <= (anXVector) (not (> self anXVector)))
  (method >= (anXVector) (not (< self anXVector)))
  (method min: (anXVector) (if (< self anXVector) {self} {anXVector}))
  (method max: (anXVector) (if (> self anXVector) {self} {anXVector}))

  ;;
  ;; Producer methods
  ;;
  (method + (anXVector) (withXV1:withXV2: ConcatXVector self anXVector))
  (method * (anInteger) (withXV:withN: RepeatXVector self anInteger))
  (method reverse () (withXV: ReverseXVector self))
  (method fromIndex:toIndex: (sindex eindex) (locals index) (error: self #unimplimented))
    ;(if (< sindex eindex)
    ;    {(set index sindex)
    ;    (timesRepeat: (- (- eindex sindex) 1)
    ;        {(+ (at:)})}
    ;    {}))
)


(class ArrayXVector XVector
  (arr) 
  (class-method withArr: (arr) (withArr: (new self) arr))
  (method withArr: (thatArr) (set arr (from: Array thatArr)) self)
  (method debug ()
    (print #ArrayXVector) (print s-lparen) (print arr) (print s-rparen))
  (method size () (size arr))
  (method elem: (anIndex) (at: arr anIndex))
)

;(class ConcatXVector XVector
;  (x1 x2) ; add instance variables as necessary
;  (class-method withXV1:withXV2: (xv1 xv2) (withXV1:withXV2 (new self) xv1 xv2))
;  (method withXV1:withXV2: (x1 x2) self)
;  (method debug () (error: self #unimplemented-size))
;    ;(print #ConcatXVector) (print s-lparen) (print xv1) (print xv2) (print s-rparen))
;  (method size () (error: self #unimplemented-size))
;  (method elem: (index) (at:ifAbsent: x1 index {(at: x2 index)}))
;)

(class RepeatXVector XVector
  () ; add instance variables as necessary
  (class-method withXV:withN: (xv n) (error: self #unimplemented-withXV:withN:))
  (method debug () (error: self #unimplemented-debug))
  (method size () (error: self #unimplemented-size))
  (method elem: (index) (error: self #unimplemented-elem:))
)

(class ReverseXVector XVector
  () ; add instance variables as necessary
  (class-method withXV: (xv) (error: self #unimplemented-withXV:))
  (method debug () (error: self #unimplemented-debug))
  (method size () (error: self #unimplemented-size))
  (method elem: (index) (error: self #unimplemented-elem:))
)

(class SwizzleXVector XVector
  () ; add instance variables as necessary
  (class-method withXV1:withXV2: (xv1 xv2) (error: self #unimplemented-withXV1:withXV2:))
  (method debug () (error: self #unimplemented-debug))
  (method size () (error: self #unimplemented-size))
  (method elem: (index) (error: self #unimplemented-elem:))
)

(class BlockXVector XVector
  () ; add instance variables as necessary
  (class-method withN:withBlock: (n block) (error: self #unimplemented-withN:withBlock:))
  (method debug () (error: self #unimplemented-debug))
  (method size () (error: self #unimplemented-size))
  (method elem: (index) (error: self #unimplemented-elem:))
)
