--Data types

data Const = IConst Integer                  |
             BConst Bool                     |
             FConst1 String (Const -> Const) |
             FConst2 String (Const -> Const -> Const)

instance Show Const where
    show (IConst x)    = show x
    show (BConst x)    = show x
    show (FConst1 s x) = "<prim1:" ++ s ++ ">"
    show (FConst2 s x) = "<prim2:" ++ s ++ ">"

instance Eq Const where
    (IConst x) == (IConst x1)        = x == x1
    (BConst x) == (BConst x1)        = x == x1
    (FConst1 s x) == (FConst1 s1 x1) = s == s1
    (FConst2 s x) == (FConst2 s1 x1) = s == s1

data Exp = Econ Const        |
           Var String        |
           Lambda String Exp |
           IfExp Exp Exp Exp |
           Appl Exp Exp 

instance Show Exp where
    show (Econ x)       = "Econ " ++ show x
    show (Var x)        = "Var " ++ show x
    show (Lambda x exp) = "Lambda " ++ show x ++ " (" ++ show exp ++ ")"
    show (IfExp x y z)  = "IfExp (" ++ show x ++ ") (" ++ show y ++ ") (" ++ show z ++ ")"
    show (Appl x y)     = "Appl (" ++ show x ++ ") (" ++ show y ++ ")"

instance Eq Exp where
    (Econ x) == (Econ x1)          = x == x1
    (Var x) == (Var x1)            = x == x1
    (Lambda x y) == (Lambda x1 y1) = y == y1

data CExp = Ccon Const      |
            CVar String     |
            Cop COp         |
            CAppl CExp CExp 

instance Show CExp where
    show (Ccon x)    = "Ccon " ++ show x
    show (CVar x)    = "CVar " ++ show x
    show (Cop x)     = "Cop " ++ show x
    show (CAppl x y) = "CAppl " ++ "(" ++ show x ++ ") (" ++ show y ++ ")"

instance Eq CExp where
    (Ccon x) == (Ccon x1)        = x == x1
    (CVar x) == (CVar x1)        = x == x1
    (Cop x) == (Cop x1)          = x == x1
    (CAppl x y) == (CAppl x1 y1) = x == x1 && y == y1
    x == y                       = False

data COp = S |
           K |
           I |
           B |
           C |
           CIf deriving (Show, Eq)

--Initial Environment

primAbs :: Const -> Const
primAbs (IConst x) | x >= 0    = IConst x
                   | otherwise = IConst (0-x)

primPlus :: Const -> Const -> Const
primPlus (IConst x) (IConst y) = IConst (x+y)

primMinus :: Const -> Const -> Const
primMinus (IConst x) (IConst y) = IConst (x-y)

primTimes :: Const -> Const -> Const
primTimes (IConst x) (IConst y) = IConst (x*y)

primDiv :: Const -> Const -> Const
primDiv (IConst x) (IConst y) = IConst (div x y)

primEq :: Const -> Const -> Const
primEq x y = BConst (x==y)

initEnv :: [(String,Const)]
initEnv = [("abs",FConst1 "abs" primAbs),
           ("+",FConst2 "+" primPlus),
           ("-",FConst2 "-" primMinus),
           ("*",FConst2 "*" primTimes),
           ("div",FConst2 "div" primDiv),
           ("==",FConst2 "==" primEq)] 

env :: String -> [(String,Const)] -> CExp
env x []         = CVar x
env x ((n,f):xs) | x == n = compile (Econ f)
                 | otherwise = env x xs

--Functions

compile :: Exp -> CExp
compile (Econ x)      = Ccon x
compile (Var x)       = CVar x
compile (IfExp x y z) = CAppl (CAppl (CAppl (Cop CIf) (compile x)) (compile y)) (compile z)
compile (Lambda x y)  = abstract x (compile y) initEnv
compile (Appl x y)    = CAppl (compile x) (compile y)

abstract :: String -> CExp -> [(String,Const)] -> CExp
abstract n (Ccon x) rho             = CAppl (Cop K) (Ccon x)
abstract n (CVar x) rho | n == x    = Cop I
                        | otherwise = CAppl (Cop K) (env x rho)
abstract n (Cop x) rho              = CAppl (Cop K) (Cop x)
abstract n (CAppl x y) rho =
    let x' = (abstract n x rho)
        y' = (abstract n y rho)
        abs2 x@(CAppl (Cop K) x') y@(Cop I)            = x'
        abs2 x@(CAppl (Cop K) x') y@(CAppl (Cop K) y') = CAppl (Cop K) (CAppl x' y')
        abs2 x@(CAppl (Cop K) x') y                    = CAppl (CAppl (Cop B) x') y
        abs2 x y@(CAppl (Cop K) y')                    = CAppl (CAppl (Cop C) x) y'
        abs2 x y                                       = CAppl (CAppl (Cop S) x) y
    in abs2 x' y'

reduceComb :: CExp -> CExp
reduceComb (CAppl (Cop I) x)                                           = x
reduceComb (CAppl (CAppl (Cop K) x) y)                                 = x
reduceComb (CAppl (CAppl (CAppl (Cop S) f) g) x) 
    = reduceComb (CAppl (reduceComb (CAppl f x)) (reduceComb (CAppl g x)))
reduceComb (CAppl (CAppl (CAppl (Cop B) f) g) x) 
    = reduceComb (CAppl f (reduceComb (CAppl g x)))
reduceComb (CAppl (CAppl (CAppl (Cop C) f) x) y) 
    = reduceComb (CAppl (reduceComb (CAppl f y)) x)
reduceComb (CAppl (CAppl (CAppl (Cop CIf) (Ccon (BConst True))) x) y)  = x
reduceComb (CAppl (CAppl (CAppl (Cop CIf) (Ccon (BConst False))) x) y) = y
reduceComb (CAppl (Ccon (FConst1 fs f)) (Ccon x)) = Ccon (f x)
reduceComb (CAppl (CAppl (Ccon (FConst2 fs f)) (Ccon x)) (Ccon y)) = Ccon (f x y)
reduceComb x = x

run :: CExp -> CExp
run = (visitUntilUnchanged reduceComb)

visitUntilUnchanged :: (CExp -> CExp) -> CExp -> CExp
visitUntilUnchanged f tr = let new = f tr
                           in if new == tr
                              then tr
                              else visitUntilUnchanged f new

compileAndRun :: Exp -> CExp
compileAndRun = (run . compile)
