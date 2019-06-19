module Sequences where

newtype Fractional a => Seq a = Seq [a] 

instance (Fractional a, Show a) => Show (Seq a) where 
  show (Seq seq) = 
    let show' 0 _      = "..."
        show' k (x:xs) = (show x) ++ "," ++ (show' (k-1) xs)
    in show' 7 seq 

limit :: (Fractional a, Ord a) => Int -> Int -> a -> Seq a -> a
limit n m epsilon (Seq seq) =
  let goOut n' seq@(x0:x1:xs)
        | n' >= n                 = error "beyond allowed bound"
        | abs (x0 - x1) < epsilon = check n' x0 seq
        | otherwise               = goOut (n'+1) xs
      check n' x0 seq             =
        if all (\x1->abs (x0 - x1) < epsilon) (take m seq) then x0 else (goOut (n'+m) (drop m seq))
  in goOut 0 seq


limitD :: Seq Double -> Double
limitD = (limit 1000 20 0.000000000000001)


average :: Fractional a => a -> a -> a
average x y = (x+y)/2

improveSqrtGuess :: Fractional a => a -> a -> a
improveSqrtGuess a g = average g (a/g)

-- already defined in Haskell
-- iterate :: (a->a) -> a -> [a]
-- iterate f x0 = x0:(iterate f (f x0))

sqrtApprox :: Fractional a => a -> Seq a
sqrtApprox a = Seq (iterate (improveSqrtGuess a) 1)


mySqrt :: Double -> Double
mySqrt = limitD . sqrtApprox



eulerTransform :: Fractional a => Seq a -> Seq a
eulerTransform (Seq (x0:x1:x2:xs)) =
    let (Seq es) = (eulerTransform (Seq xs))
    in Seq ((x2 - ((x2-x1)^2)/(x0-2*x1+x2)):es)

accelerate :: Fractional a => Seq a -> Seq a
accelerate seq = Seq [x | (Seq (x:xs)) <- iterate eulerTransform seq]
