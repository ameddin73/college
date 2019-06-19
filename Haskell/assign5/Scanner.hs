module Scanner where

import Data.Char

data Token = Simple SimpleToken     | 
             Compound CompoundToken | 
             LexError String Char deriving (Eq, Show)

data SimpleToken = EOF   | 
                   COMMA | 
                   PLUS  | 
                   MINUS | 
                   STAR  | 
                   SLASH | 
                   EQ1   | 
                   OP    | 
                   CP    | 
                   LET   | 
                   IN deriving (Eq, Show)

data CompoundToken = Id String | Num Integer deriving (Eq, Show)

stateStart :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateStart "" seen k = k (Simple EOF) ""
stateStart (',':cs) seen k = stateHasComma cs (',':seen) k
stateStart ('+':cs) seen k = stateHasPlus cs ('+':seen) k
stateStart ('-':cs) seen k = stateHasMinus cs ('-':seen) k
stateStart ('*':cs) seen k = stateHasStar cs ('*':seen) k
stateStart ('/':cs) seen k = stateHasSlash cs ('/':seen) k
stateStart ('=':cs) seen k = stateHasEq cs ('=':seen) k
stateStart ('(':cs) seen k = stateHasOP cs ('(':seen) k
stateStart (')':cs) seen k = stateHasCP cs (')':seen) k
stateStart ('l':cs) seen k = stateHasL cs ('l':seen) k
stateStart ('i':cs) seen k = stateHasI cs ('i':seen) k
stateStart (c:cs) seen k 
  | isSpace c = stateStart cs seen k
  | isAlpha c = stateHasAlpha cs (c:seen) k
  | isDigit c = stateHasNum cs (c:seen) k
  | otherwise = k (LexError "Unexpected character: " c) (c:cs)

stateHasComma :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasComma cs seen k = k (Simple COMMA) cs

stateHasPlus :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasPlus cs seen k = k (Simple PLUS) cs

stateHasMinus :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasMinus cs seen k = k (Simple MINUS) cs

stateHasStar :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasStar cs seen k = k (Simple STAR) cs

stateHasSlash :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasSlash cs seen k = k (Simple SLASH) cs

stateHasEq :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasEq cs seen k = k (Simple EQ1) cs

stateHasOP :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasOP cs seen k = k (Simple OP) cs

stateHasCP :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasCP cs seen k = k (Simple CP) cs

stateHasL :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasL "" seen k = k (Compound (Id (reverse seen))) ""
stateHasL ('e':cs) seen k = stateHasLE cs ('e':seen) k
stateHasL (c:cs) seen k 
   | isAlpha c      = stateHasAlpha cs (c:seen) k
   | otherwise      = k (Compound (Id (reverse seen))) (c:cs)

stateHasLE :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasLE "" seen k = k (Compound (Id (reverse seen))) ""
stateHasLE ('t':cs) seen k = stateHasLET cs ('t':seen) k
stateHasLE (c:cs) seen k 
   | isAlpha c      = stateHasAlpha cs (c:seen) k
   | otherwise      = k (Compound (Id (reverse seen))) (c:cs)

stateHasLET :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasLET "" seen k = k (Simple LET) ""
stateHasLET (c:cs) seen k 
   | isAlpha c      = stateHasAlpha cs (c:seen) k
   | otherwise      = k (Simple LET) (c:cs)

stateHasI :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasI "" seen k = k (Compound (Id (reverse seen))) ""
stateHasI ('n':cs) seen k = stateHasIN cs ('n':seen) k
stateHasI (c:cs) seen k 
   | isAlpha c      = stateHasAlpha cs (c:seen) k
   | otherwise      = k (Compound (Id (reverse seen))) (c:cs)


stateHasIN :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasIN "" seen k = k (Simple IN) ""
stateHasIN (c:cs) seen k 
   | isAlpha c      = stateHasAlpha cs (c:seen) k
   | otherwise      = k (Simple IN) (c:cs)


stateHasAlpha :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasAlpha "" seen k = k (Compound (Id (reverse seen))) ""
stateHasAlpha (c:cs) seen k 
   | isAlpha c      = stateHasAlpha cs (c:seen) k
   | otherwise      = k (Compound (Id (reverse seen))) (c:cs)


stateHasNum :: [Char] -> [Char] -> (Token -> [Char] -> t) -> t
stateHasNum "" seen k = k (Compound (Num (read (reverse seen)))) ""
stateHasNum (c:cs) seen k 
   | isDigit c      = stateHasNum cs (c:seen) k
   | otherwise      = k (Compound (Num (read (reverse seen)))) (c:cs)


getToken :: [Char] -> (Token -> [Char] -> t) -> t
getToken s k = stateStart s "" k

-- token stream constructor


tokenStreamFromString :: [Char] -> [Token]
tokenStreamFromString s = let k t s = t:(getToken s k)
                          in getToken s k

-- token stream interface

isEmptyTokenStream :: [Token] -> Bool
isEmptyTokenStream (t:ts) = (t == (Simple EOF))

-- peek and advance via ordinary list operations
