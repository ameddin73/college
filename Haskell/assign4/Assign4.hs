index_a :: Eq a => a -> [a] -> (Integer->Integer) -> Maybe Integer
index_a c [] k = Nothing
index_a c (x:xs) k | c == x = Just (k 1)
                   | otherwise = index_a c xs (\v->k(v+1))

----------

newtype K r a = K ((a -> r) -> r)

(<<<) :: K r a -> (a -> r) -> r
(K f) <<< k = f k

instance Monad (K r) where
    return v = K(\k->k v)
    m >>= f  = K(\k->m <<< (\a->(f a) <<< k))

instance Applicative (K r) where
    pure  = return
    mf <*> ma = do f <- mf
                   a <- ma
                   return (f a)

instance Functor (K r) where
  fmap g fx = (pure g) <*> fx

abortWith :: (Maybe Integer) -> (K (Maybe Integer) (Maybe Integer))
abortWith v = K(\k->v)

index_b :: Eq a => a -> [a] -> (K (Maybe Integer) (Maybe Integer))
index_b c [] = (return Nothing) >>= abortWith
index_b c (x:xs) | c == x = return (Just 1) 
                 | otherwise = do Just v <- (index_b c xs); return (Just (v+1))

topIndex_b :: Eq a => a -> [a] -> Maybe Integer
topIndex_b x xs = (index_b x xs) <<< id

----------

index_c :: Eq a => a -> [a] -> Maybe Integer
index_c c [] = Nothing
index_c c (x:xs) | c == x = return 1
                 | otherwise = index_c c xs >>= (\v->(Just (v+1))) 

----------

index_d :: Eq a => a -> [a] -> Maybe Integer
index_d c [] = Nothing
index_d c (x:xs) | c == x = return 1
                 | otherwise = do v <- index_d c xs; return (v+1)

----------

meetAndGreet :: IO()
meetAndGreet =
    do putStr "What is your name? "
       s <- getLine
       putStrLn ("Hello " ++ s ++ "!")

----------

average :: (Fractional double) => [double] -> double
average = uncurry (/) . foldr (\e (s,c) -> (e+s,c+1)) (0,0) 

readDoubles :: IO [Double]
readDoubles =
    do putStr "Enter a number: "
       line <- getLine
       if line /= "done"
           then 
               do d <- readDoubles; return (((read line)::Double):d)
           else return []

interface :: IO()
interface =
    do putStrLn "Enter some number.\nWhen finished, type 'done'."
       xs <- readDoubles
       let avg = average xs
       let mx = maximum xs
       let mn = minimum xs
       putStrLn ("The average is "++(show avg))
       putStrLn ("The maximum is "++(show mx))
       putStrLn ("The minimum is "++(show mn))
