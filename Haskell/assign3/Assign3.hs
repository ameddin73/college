-- author: Alex Meddin

import Data.Ratio
import Sequences
import Series
import MPoly
import Data.List

sinPowSeD :: PowSe Double 
sinPowSeD =
    let fact n = product [1..n]
        cosS (x0:x1:x2:x3:xs) = (x0/(fact x0)):0:(-1*(x2/(fact x2))):0:(cosS xs)
        cosP (PowSe xs) = PowSe (cosS xs)
    in integratePlus (cosP expPowSeD) 0

sinPowSeR :: PowSe Rational
sinPowSeR =
    let fact n = product [1..n]
        cosS (x0:x1:x2:x3:xs) = (x0/(fact x0)):0:(-1*(x2/(fact x2))):0:(cosS xs)
        cosP (PowSe xs) = PowSe (cosS xs)
    in integratePlus (cosP expPowSeR) 0

cosPowSeD :: PowSe Double
cosPowSeD = integratePlus (-1 * sinPowSeD) 1

cosPowSeR :: PowSe Rational 
cosPowSeR = integratePlus (-1 * sinPowSeR) 1 

mySine :: Double -> Integer -> Double
mySine theta n | theta < 0.000000001 && theta > -0.000000001 = theta
               | otherwise = 
                    let sinT = approxFromPowSe n sinPowSeD (theta/3)
                    in 3*sinT - 4*sinT^3

sub :: (Num a, Fractional a) => [a] -> [a] -> [a]
sub [] [] = []
sub (x:xs) (y:ys) = (x-y):(sub xs ys)

scaleList :: (Num a, Fractional a) => a -> [a] -> [a]
scaleList n [] = []
scaleList n (x:xs) = (n*x):(scaleList n xs)

subScale :: (Num a, Fractional a) => [a] -> [a] -> [a]
subScale [] [] = []
subScale (x:xs) (y:ys) = sub ys (scaleList (y/x) xs)

nonZeroFirst :: (Eq a, Fractional a) => [[a]] -> [[a]]
nonZeroFirst [] = []
nonZeroFirst lst@(x0:x1:xs) | head x0 /= 0 = lst
                            | head x1 /= 0 = x1:x0:xs
                            | otherwise = x0:x1:(nonZeroFirst xs)
nonZeroFirst x = x

triangulate :: (Eq a, Fractional a) => [[a]] ->[[a]]
triangulate [] = []
triangulate (x:xs) =
    let scld [] = []
        scld (y:ys) = (nonZeroFirst ((subScale x y):(scld ys)))
    in x:(triangulate (scld xs))

dot :: (Num a, Fractional a) => [a] -> [a] -> a
dot [] [] = 0
dot [] ys = sum ys
dot xs [] = sum xs
dot (x:xs) (y:ys) = (x*y) + (dot xs ys)

solveLine :: (Num a, Fractional a) => [a] -> [a] -> a
solveLine (x:xs) ys =
    let xVars = take ((length xs) - 1) xs
        sumE = last xs
        dotE = dot xVars ys
    in (sumE - dotE) / x 

solveTriangular :: (Eq a, Fractional a) => [[a]] -> [a]
solveTriangular lst =
    let solv _ [] = []
        solv s (x:xs) = (solveLine x (solv s xs)):(solv s xs)
    in solv [] lst

solveSystem :: (Eq a, Fractional a) => [[a]] -> [a]
solveSystem lst = solveTriangular (triangulate lst)

-------------------------------------------------------------------------------

data Exp = RExp Rational  |
           Var String     |
           Sum Exp Exp    |
           Prod Exp Exp   |
           Pow Exp Exp    |
           D Exp String deriving Eq

instance Show Exp where
    show x = showSumContext x

addParens :: String -> String
addParens x = "("++x++")"

showSumContext :: Exp -> String
showSumContext (RExp n) =
    let nume = numerator n
        deno = denominator n
        show' | deno == 1 = show nume
              | otherwise = (show nume)++"/"++(show deno)
    in if n < 0 then addParens show' else show'
showSumContext (Var x) = x 
showSumContext (Sum u v) = (showSumContext u)++"+"++(showSumContext v)
showSumContext (Prod u v) = (showProdContext u)++"*"++(showProdContext v)
showSumContext (Pow u v) = (showPowContextLeft u)++"^"++(showPowContextRight v)
showSumContext (D u x) = "D("++(show u)++", "++x++")"

showProdContext :: Exp -> String
showProdContext exp@(RExp n) = show exp
showProdContext exp@(Var x) = show exp
showProdContext exp@(Sum u v) = addParens (show exp)
showProdContext exp@(Prod u v) = show exp
showProdContext exp@(Pow u v) = show exp
showProdContext exp@(D u x) = show exp

showPowContextLeft :: Exp -> String
showPowContextLeft exp@(RExp n) | denominator n == 1 = show exp
                                | n < 0 = show exp
                                | otherwise = addParens (show exp)
showPowContextLeft exp@(Var x) = show exp
showPowContextLeft exp@(Sum u v) = addParens (show exp)
showPowContextLeft exp@(Prod u v) = addParens (show exp)
showPowContextLeft exp@(Pow u v) = addParens (show exp)
showPowContextLeft exp@(D u x) = show exp

showPowContextRight :: Exp -> String
showPowContextRight exp@(RExp n) | denominator n == 1 = show exp
                                 | otherwise = addParens (show exp)
showPowContextRight exp@(Var x) = show exp
showPowContextRight exp@(Sum u v) = addParens (show exp)
showPowContextRight exp@(Prod u v) = addParens (show exp)
showPowContextRight exp@(Pow u v) = show exp
showPowContextRight exp@(D u x) = show exp

rEval :: Exp -> Rational 
rEval (RExp n) = n
rEval (Var x) = error "Variable encountered in rational expression"
rEval (Sum u v) = (rEval u) + (rEval v)
rEval (Prod u v) = (rEval u) * (rEval v)
--rEval (Pow u v) = (rEval u) ^ (rEval v)

deriv :: Exp -> String -> Exp
deriv (RExp n) x = RExp 0
deriv (Var x) y
  | x == y    = RExp 1
  | otherwise = RExp 0
deriv (Sum u v) x  = Sum (deriv u x) (deriv v x)
deriv (Prod u v) x = Sum (Prod u (deriv v x)) (Prod v (deriv u x))
deriv (Pow u (RExp n)) x = (Prod (Prod (RExp n) (Pow u (RExp (n-1))))
                                 (deriv u x))

visitOnce :: (Exp -> Exp) -> Exp -> Exp
visitOnce f e@(RExp n) = e
visitOnce f e@(Var x)  = e
visitOnce f (Sum u v)  = f (Sum (visitOnce f u) (visitOnce  f v))
visitOnce f (Prod u v) = f (Prod (visitOnce f u) (visitOnce f v))
visitOnce f (Pow u v)  = f (Pow (visitOnce f u) (visitOnce f v))
visitOnce f (D u x)  = f (D (visitOnce f u) x) 


simp :: Exp -> Exp
simp (Sum (RExp n) (RExp m))  = RExp (n+m)
simp (Sum (RExp 0) v)         = v
simp (Sum u (RExp 0))         = u
simp (Prod (RExp n) (RExp m)) = RExp (n*m)
simp (Prod (RExp 0) v)        = RExp 0
simp (Prod u (RExp 0))        = RExp 0
simp (Prod (RExp 1) v)        = v
simp (Prod u (RExp 1))        = u
simp (Pow u (RExp 0))         = RExp 1
simp (Pow u (RExp 1))         = u
simp u                        = u

simplify1 :: Exp -> Exp
simplify1  = (visitOnce simp)
visitUntilUnchanged :: (Exp -> Exp) -> Exp -> Exp
visitUntilUnchanged f tr = let new = visitOnce f tr
                           in if new == tr
                              then tr
                              else visitUntilUnchanged f new

simp3 :: Exp -> Exp
simp3 (Sum (RExp n) (RExp m))           = RExp (n+m)
simp3 (Sum (RExp n) v)                  = (Sum v (RExp n))
simp3 (Sum u (RExp 0))                  = u
simp3 (Sum (Sum u (RExp n)) (RExp m))   = Sum u (RExp (n+m))
simp3 (Sum (Sum u (RExp n)) v)          = Sum (Sum u v) (RExp n)
simp3 (Sum u (Sum v w))                 = Sum (Sum u v) w
simp3 (Sum u v)
  | u == v                              = Prod (RExp 2) u
simp3 (Sum (Prod (RExp n) u) v)
  | u == v                              = Prod (RExp (n+1)) u
simp3 (Sum u (Prod (RExp n) v))
  | u == v                              = Prod (RExp (n+1)) u
simp3 (Sum (Prod (RExp n) u) (Prod (RExp m) v))
  | u == v                              = Prod (RExp (n+m)) u
simp3 (Prod (RExp n) (RExp m))          = RExp (n*m)
simp3 (Prod u (RExp n))                 = Prod (RExp n) u
simp3 (Prod (RExp 0) v)                 = RExp 0
simp3 (Prod (RExp 1) v)                 = v
simp3 (Prod (RExp n) (Prod (RExp m) v)) = Prod (RExp (n*m)) v
simp3 (Prod u (Prod (RExp n) v))        = Prod (RExp n) (Prod u v)
simp3 (Prod (Prod u v) w)               = Prod u (Prod v w)
simp3 (Prod (RExp n) (Sum u v))         = Sum (Prod (RExp n) u) (Prod (RExp n) v)
simp3 (Prod (Var y) (Var x))
  | y == x                              = Pow (Var x) (RExp 2)
simp3 (Prod (Var y) (Sum (Var x) (RExp n)))
  | y == x                              = Sum (Prod (Var y) (Var x)) (Prod (Var y) (RExp n))
simp3 (Pow u (RExp 0))                  = RExp 1
simp3 (Pow u (RExp 1))                  = u
simp3 (D (RExp n) x)                    = RExp 0
simp3 (D (Var y) x)
  | y == x                              = RExp 1
  | otherwise                           = RExp 0
simp3 (D (Sum n m) x)                   = Sum (D n x) (D m x)
simp3 (D (Prod (RExp n) m) x)             = Prod (RExp n) (D m x)
simp3 (D (Pow (Var y) (RExp n)) x) 
  | y == x                              = Prod (RExp n) (Var x)
  | otherwise                           = RExp 0
simp3 (D (Prod (Var z) (Pow (RExp n) (Var y))) x) 
  | y == x && z == x = Sum (Prod (Var y) (D (Pow (RExp n) (Var x)) x)) (Pow (RExp n) (Var x))
  | otherwise                           = RExp 0
simp3 u                                 = u

simplify3 :: Exp -> Exp
simplify3 = (visitUntilUnchanged simp3)

-------------------------------------------------------------------------------

data Eqn = Eqn Exp Exp

system :: [Eqn] -> [[Rational]]
system eqs =
    let polys [] = []
        polys ((Eqn e0 e1):es) = [(fromExp e0),(fromExp e1)]:(polys es)
        comp ((ProdPlus _ a _):p0) ((ProdPlus _ b _):p1) = compare a b
        splst = sortBy comp (polys eqs)
        getV (ProdPlus _ (KVar x) (Const c)) = [x]
        getV (ProdPlus _ (KVar x) p) = x:(getV p)
        vars =  map head (group  (sort (foldr (++) [] (map (getV . head) splst))))
        elst fc [] (ProdPlus _ _ (Const c)) = [fc-c]
        elst fc (v:vs) p@(ProdPlus (Const c) (KVar k) b)
            | k == v = c:(elst fc vs b)
            | otherwise = 0:(elst fc vs p)
        elst fc v (Const c) = (take (length v) [0,0..])++[fc-c]
        elst fc v p = (take (length v) [0,0..])++[fc]
        emk v [p0,Const c] = elst c v p0
        sys v [] = []
        sys v (y:ys) = (emk v y):(sys v ys)
    in sys vars splst

fromRatio :: Rational -> MPoly
fromRatio = fromConst . fromRational

-------------------------------------------------------------------------------

fromExp :: Exp -> MPoly
fromExp (RExp n)   = fromRatio n
fromExp (Var x)    = fromVar x
fromExp (Sum u v)  = (fromExp u) + (fromExp v)
fromExp (Prod u v) = (fromExp u) * (fromExp v)
--fromExp (Pow u v)  = let n = rEval v
--                     in if n >=0 then (fromExp u) ^ n
--                        else error "Fractional polynomial encountered"
