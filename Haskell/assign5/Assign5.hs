module Assign5  where

import Scanner
import Data.List

data Exp = RExp Integer   | 
           Var String     | 
           Sum Exp Exp    | 
           Diff Exp Exp   | 
           Prod Exp Exp   |
           Quo Exp Exp    |
           Neg Exp deriving (Eq, Show)

data EqnSeq = Seq [Eqn]   |
              ParseEqnSeqError String deriving (Eq, Show)
data Eqn = Eqn Exp Exp deriving (Eq, Show)

stringFromToken :: Token -> String
stringFromToken (Compound (Id s)) = s

integerFromToken :: Token -> Integer
integerFromToken (Compound (Num n)) = n

-- Grammar
-- S ::= Q , S
--   ::= Q
-- Q ::= E = E
-- E ::= T E'
-- E'::= + T E'
--   ::= - T E'
--   ::= ε
-- T ::= F T'
-- T'::= * F T'
--   ::= / F T'
--   ::= ε
-- F ::= id
--   ::= num
--   ::= - F
--   ::= ( E )

newtype Parser a = Parser ([Token] -> [(a, [Token])])

unWrap (Parser f) = f

instance Monad Parser where
  return a = Parser(\ts->[(a, ts)])
  p >>= f  = Parser(\ts->[(b, ts2) | (a, ts1) <- unWrap p ts, (b, ts2) <- unWrap (f a) ts1])
  fail s   = Parser(\ts-> [])


instance Applicative Parser where
    pure  = return
    mf <*> ma = do f <- mf
                   a <- ma
                   return (f a)

instance Functor Parser where
  fmap g fx = (pure g) <*> fx

-- item makes sense for "token" Parsers
item :: Parser Token
item = Parser(\ts->case ts of [] -> []; t:ts1 -> [(t,ts1)])

parserFilter :: Parser b -> (b -> Bool) -> Parser b
parserFilter parser p = do {a <- parser; if p a then return a else (fail "Parser")}

literal :: Token -> Parser Token
literal t = parserFilter item (==t)

variable :: Parser Token
variable =  parserFilter item (\tok->case tok of (Compound (Id _)) -> True; _ -> False)

number :: Parser Token
number =  parserFilter item (\tok->case tok of (Compound (Num _)) -> True; _ -> False)

(+++) :: Parser a -> Parser a -> Parser a
p1 +++ p2 = Parser(\ts-> (unWrap p1 ts) ++ (unWrap p2 ts))

getEqnSeqs :: Parser EqnSeq
getEqnSeqs = getEqnSeqs2 []

getEqnSeqs2 :: [Eqn] -> Parser EqnSeq
getEqnSeqs2 revEqns =
  do eqn <- getEqn
     ((do tok <- (literal (Simple COMMA))
          getEqnSeqs2 (eqn:revEqns))
       +++
      (return (Seq (reverse (eqn:revEqns)))))

getEqn :: Parser Eqn
getEqn = 
  do exp1 <- getMathExp
     tok <- (literal (Simple EQ1))
     exp2 <- getMathExp
     return (Eqn exp1 exp2)

getMathExp :: Parser Exp
getMathExp = 
  do term <- getTerm
     getMathExp' term

getMathExp' :: Exp -> Parser Exp
getMathExp' term =
  (do tok <- (literal (Simple PLUS)) 
      term2 <- getTerm
      getMathExp' (Sum term term2))
  +++
  (do tok <- (literal (Simple MINUS))
      term2 <- getTerm
      getMathExp' (Diff term term2))
  +++
   (return term)

getTerm :: Parser Exp
getTerm = 
  do factor <- getFactor
     getTerm' factor

getTerm' :: Exp -> Parser Exp
getTerm' factor = 
  (do tok <- (literal (Simple STAR))
      factor2 <- getFactor
      getTerm' (Prod factor factor2))
  +++
  (do tok <- (literal (Simple SLASH))
      factor2 <- getFactor
      getTerm' (Quo factor factor2))
  +++
   (return factor)

getFactor :: Parser Exp
getFactor = 
  (do vtok <- variable
      return (Var (stringFromToken vtok)))
  +++
  (do ntok <- number
      return (RExp (integerFromToken ntok)))
  +++
  (do tok <- (literal (Simple MINUS))
      factor <- getFactor
      return (Neg factor))
  +++
  (do tok <- (literal (Simple OP)) 
      exp <- getMathExp
      tok <- (literal (Simple CP))
      return exp)

parse :: [Token] -> EqnSeq
parse ts =
  case unWrap getEqnSeqs ts of
    []            -> ParseEqnSeqError "Bad input" 
    (exp, ts1):ps -> if isEmptyTokenStream ts1
                     then exp
                     else ParseEqnSeqError "Unconsumed input" 

parseString :: String -> EqnSeq
parseString = parse . tokenStreamFromString

-------------------------------------------------------------------------------

data Str = EStr | ConCat Str Char 


stringFromStr :: Str -> String
stringFromStr s = 
   let helper EStr a         = a
       helper (ConCat s c) a = helper s (c:a)
   in helper s ""

instance Show Str where
  show s = "<" ++ (stringFromStr s) ++ ">"

data RegExp sigma = RegEmpty                             |
                    RegEpsilon                           |
                    RegSym sigma                         |
                    RegOr (RegExp sigma) (RegExp sigma)  |
                    RegSeq (RegExp sigma) (RegExp sigma) |
                    RegStar (RegExp sigma) deriving Show

data NFA q sigma = NFA (q->sigma->[Q]) Q [Q]

data Sigma = Sigma String |
             SigmaEpsilon (Maybe Sigma) deriving Show

data Q = Q Char deriving (Eq,Show)

epsilonClosure :: (NFA [Q] Sigma) -> [Q] -> [Q]
epsilonClosure (NFA f es qs) sts =
    let e = SigmaEpsilon Nothing
        curCloses = union sts (f sts e)
        allCloses = union curCloses (f curCloses e)
    in if curCloses == allCloses then curCloses
       else epsilonClosure (NFA f es qs) curCloses

