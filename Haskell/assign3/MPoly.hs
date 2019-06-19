-- Author: Arthur Nunes-Harwitt

module MPoly where

import Data.Ratio


-- R[x1, ..., xn] is defined recursively as follows.
-- * c in R[x1,...,xn] if c in R
-- * p1*x1+p2 in R[x1, ..., xn] if p1 in R[x1,...,xn] and p2 in R[x2,...,xn]
--   for canonical form, p1 should not be 0


data MPoly = Const Rational | ProdPlus MPoly Kernel MPoly deriving Eq

data Kernel = KVar String deriving Eq

instance Show Kernel where
  show (KVar s) = s

instance Ord Kernel where
  compare (KVar x) (KVar y) = compare x y

signumString :: (Eq a, Num a) => a -> String
signumString n = 
  case (signum n) of 
     (-1) -> "-"
     (0)  -> ""
     (1)  -> "+"

instance Show MPoly where
  show p = 
    let show' fs (Const q)         = (signumString q, showTerm (abs q) fs)
        show' fs (ProdPlus p1 x p2) =
          let (sign2, str2) = show' fs p2
              (sign1, str1) = show' (mulFactor x fs) p1
          in case sign2 of
               ""        -> (sign1, str1)
               otherwise -> (sign1, str1 ++ sign2 ++ str2)
        mulFactor x [] = [(x, 1)]
        mulFactor x ((y, n):fs) 
           | x == y    = ((x, n+1):fs) 
           | otherwise = (x, 1):((y, n):fs) 
        showPow []          = "_" -- Should not happen
        showPow [(x, 1)]    = (show x)
        showPow [(x, n)]    = (show x) ++ "^" ++ (show n)
        showPow ((x, 1):fs) = (show x) ++ "*" ++ (showPow fs)
        showPow ((x, n):fs) = (show x) ++ "^" ++ (show n) ++ "*" ++ (showPow fs)
        showTerm q []    = showNum q
        showTerm 1 fs    = showPow fs
        showTerm 0 fs    = ".0" -- Should not see this
        showTerm q fs    = (showNum q) ++ "*" ++ (showPow fs)
        showNum a
          | denominator a == 1     = show (numerator a)
          | otherwise              = 
              "("++(show (numerator a))++"/"++(show (denominator a))++")"
        (sign, str) = show' [] p
    in case sign of 
         ""  -> "0"
         "-" -> sign++str
         "+" -> str

fromConst :: Rational -> MPoly
fromConst a = Const a

fromVar :: String -> MPoly
fromVar x = (ProdPlus (Const 1) (KVar x) (Const 0))

scale :: Rational -> MPoly -> MPoly
scale 0 p                  = Const 0
scale a (Const b)          = Const (a*b)
scale a (ProdPlus p1 x p2) = ProdPlus (scale a p1) x (scale a p2)

mulVar :: Kernel -> MPoly -> MPoly -- multiply by x
mulVar x (Const 0)   = (Const 0)
mulVar x p@(Const a) = (ProdPlus p x (Const 0))
mulVar y p@(ProdPlus p1 x p2)
  | x < y            = (ProdPlus (mulVar y p1) x (mulVar y p2))
  | x > y            = (ProdPlus p y (Const 0))
  | otherwise        = (ProdPlus p x (Const 0))

normalPoly :: MPoly -> Kernel -> MPoly -> MPoly
normalPoly (Const 0) x p2 = p2
normalPoly p1 x p2        = ProdPlus p1 x p2

instance Num MPoly where
  (Const a) + (Const b) = Const (a+b)
  (ProdPlus p1 x p2) + (Const a) = ProdPlus p1 x ((Const a) + p2)
  (Const a) + (ProdPlus p1 x p2) = ProdPlus p1 x ((Const a) + p2)
  p@(ProdPlus p1 x p2) + p'@(ProdPlus p1' y p2') 
     | x < y     = ProdPlus p1 x (p2+p')
     | x > y     = ProdPlus p1' y (p+p2')
     | otherwise = normalPoly (p1 + p1') x (p2+p2')

  negate p = scale (-1) p

  (Const a) * p          = scale a p
  (ProdPlus p1 x p2) * p = (p1 * (x `mulVar` p)) + p2*p

  abs _ = error "abs not supported for type MPoly"
  signum _ = error "signum not supported for type MPoly"

  fromInteger  = fromConst . fromInteger

derivative :: MPoly -> String -> MPoly
derivative (Const a) x = (Const 0)
derivative (ProdPlus p (KVar s) a) x 
  | s == x             =  p + ((fromVar s) * (derivative p x)) + (derivative a x)
  | otherwise          = ((fromVar s) * (derivative p x)) + (derivative a x)

integral :: MPoly -> String -> MPoly
integral (Const 0) x                         = Const 0
integral p x = 
    let intCount (Const a) n                 = Const (a/(n+1))
        intCount p@(ProdPlus p1 (KVar s) p2) n 
          | s == x                           = ProdPlus (intCount p1 (n+1)) 
                                                        (KVar s) 
                                                        (scale (1/(n+1)) p2)
          | otherwise                        = ProdPlus (intCount p1 n) 
                                                        (KVar s) 
                                                        (intCount p2 n) 
    in  mulVar (KVar x) (intCount p 0)
