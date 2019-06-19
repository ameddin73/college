module Series where

import Data.Ratio
import Sequences

newtype (Eq a, Fractional a) => PowSe a = PowSe [a]

shift :: (Eq a, Fractional a) => PowSe a -> PowSe a
shift (PowSe xs) = PowSe (0:xs)

scale :: (Eq a, Fractional a) => a -> PowSe a -> PowSe a
scale c (PowSe xs) = PowSe [c*x | x <- xs]

zeros :: (Eq a, Fractional a) => PowSe a
zeros = let zs = 0:zs in PowSe zs

one :: (Eq a, Fractional a) => PowSe a
one   = let (PowSe zs) = zeros in PowSe (1:zs)

var :: (Eq a, Fractional a) => PowSe a
var   = shift one

signumString :: (Eq a, Num a) => a -> String
signumString n = 
  case (signum n) of 
     (-1) -> "-"
     (0)  -> ""
     (1)  -> "+"

instance (Eq a, Fractional a, Show a) => Show (PowSe a) where
  show (PowSe ser) = 
    let show' _ []     = ("","0")
        show' n [x]    = ((signumString x), "...")
        show' n (x:xs) = 
          let (sign, str) = show' (n+1) xs
          in if (signumString x) == "" then (sign, str)
                                       else ((signumString x), (showTerm (abs x) n) ++ sign ++ str)
        showTerm 0 _ = ""
        showTerm x 0 = show x
        showTerm x 1 = (show x)++"*x"
        showTerm x n = (show x)++"*x^"++(show n)
        (sign, str) = show' 0 (take 11 ser)
    in case sign of 
         ""  -> "0+"++str
         "-" -> sign++str
         "+" -> str

instance (Eq a, Fractional a) => Num (PowSe a) where
  (PowSe (x:xs)) + (PowSe (y:ys)) = let (PowSe zs) = (PowSe xs) + (PowSe ys)
                                    in PowSe ((x+y):zs)
  negate (PowSe xs) = PowSe [(-x) | x <- xs]
  (PowSe (x:xs)) * (PowSe (y:ys)) = let term4      = shift ((PowSe xs) * (PowSe ys))
                                        term3      = scale y (PowSe xs)
                                        term2      = scale x (PowSe ys)
                                        (PowSe zs) = term2 + term3 + term4
                                    in PowSe ((x*y):zs)
  abs _ = error "abs not supported for type PowSes"
  signum _ = error "signum not supported for type PowSes"
  fromInteger n = let (PowSe zs) = zeros
                  in PowSe ((fromInteger n):zs)


recipOne :: (Eq a, Fractional a) => PowSe a -> PowSe a  
recipOne (PowSe (1:sr)) = let (PowSe recip) = 1 - (shift ((PowSe sr) * (PowSe recip)))
                          in (PowSe recip)


instance (Eq a, Fractional a) => Fractional (PowSe a) where
  recip (PowSe (x:xs))
    | x == 0  = error "reciprocal not defined"
    | x == 1  = recipOne (PowSe (x:xs))
    | otherwise = scale (1/x) (recipOne (scale (1/x) (PowSe (x:xs))))
  fromRational q = let (PowSe zs) = zeros
                   in PowSe ((fromRational q):zs)



integratePlus :: (Fractional a, Eq a) => PowSe a -> a -> PowSe a
integratePlus (PowSe xs) c = 
  let scaleRecip (x:xs) n = (x/n):(scaleRecip xs (n+1))
  in PowSe (c:(scaleRecip xs 1))




expPowSeD :: PowSe Double
expPowSeD = integratePlus expPowSeD 1
            

expPowSeR :: PowSe Rational
expPowSeR = integratePlus expPowSeR 1



atanPowSeD :: PowSe Double
atanPowSeD = integratePlus (1/(1+var^2)) 0

atanPowSeR :: PowSe Rational
atanPowSeR = integratePlus (1/(1+var^2)) 0



piPowSeD :: PowSe Double
piPowSeD = let s n = PowSe ((1/n):zs)
                      where
                         (PowSe zs) = (- (s (n+2)))
           in 4*(s 1)


piPowSeR :: PowSe Rational
piPowSeR = let s n = PowSe ((1/n):zs)
                      where
                         (PowSe zs) = (- (s (n+2)))
           in 4*(s 1)


approxFromPowSe :: (Eq a, Fractional a) => Integer -> PowSe a -> a -> a
approxFromPowSe 0 (PowSe (x:xs)) x0 = x
approxFromPowSe n (PowSe (x:xs)) x0 = x + x0*(approxFromPowSe (n-1) (PowSe xs) x0)

seqFromPowSe :: (Eq a, Fractional a) => PowSe a -> a -> Seq a
seqFromPowSe ps x0 = Seq [approxFromPowSe n ps x0 | n <- [0..]]
