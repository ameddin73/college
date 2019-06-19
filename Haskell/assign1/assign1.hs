second :: [a] -> a
second (x:xs) = head xs

singleton :: Eq a => [a] -> Bool
singleton []                = False
singleton (x:xs) | xs /= [] = False
singleton _                 = True

index :: Eq a => a -> [a] -> Maybe Int
index x []              = Nothing
index x (y:ys) | x == y = Just 0
index x (y:ys) | x /= y = case (index x ys) of
    Nothing -> Nothing
    Just n  -> Just (1 + n)

evenSquares' :: [Int] -> [Int]
evenSquares' lst = (filter even (map (\x -> x*x) lst))

insert :: Ord a => a -> [a] -> [a]
insert x []              = [x]
insert x (y:ys) | y < x  = y:( insert x ys)
insert x (y:ys) | y >= x = x:y:ys

insertionSort :: Ord a => [a] -> [a]
insertionSort []     = []
insertionSort (x:xs) = insert x (insertionSort xs)
   
insertionSortH :: Ord a => [a] -> [a]
insertionSortH [] = []
insertionSortH xs = foldr insert [] xs 

perm :: Eq a => [a] -> [[a]]
perm (x:[]) = [[x]]
perm xs = [y:ys | y <- xs, ys <- perm (without y xs)]

without :: Eq a => a -> [a] -> [a]
without x []                 = []
without x (y:ys) | x == y    = ys
                 | otherwise = y:(without x ys)

data Peano = Zero | S Peano deriving Show

add :: Peano -> Peano -> Peano
add Zero Zero    = Zero
add Zero p       = p
add p Zero       = p
add (S p) (S p') = (S (S (add p p')))

mult :: Peano -> Peano -> Peano
mult Zero _   = Zero
mult p Zero   = Zero
mult (S p) p' = add p' (mult p p') 

fact :: Peano -> Peano
fact Zero     = (S Zero)
fact (S Zero) = (S Zero)
fact (S p)    = mult (S p) (fact p)
