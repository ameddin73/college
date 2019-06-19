import SymMath
import PolyMath
import Data.Ratio


fromExp :: Exp -> Poly
fromExp (IExp n) = fromInteger n
fromExp (Var x) = fromVar x
fromExp (Sum u v) = (fromExp u) + (fromExp v)
fromExp (Prod u v) = (fromExp u) * (fromExp v)
fromExp (Pow u v) = let n = intEval v
                    in if n >=0 then (fromExp u) ^ n
                       else error "Fractional polynomial encountered"

