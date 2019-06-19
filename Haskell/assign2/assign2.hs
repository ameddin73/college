module Assign2 where
import Data.List
import Solver

data SudokuConfig = SudokuConfig [[Integer]] [[Integer]] [[Integer]]
    deriving Eq

instance Show SudokuConfig where
    show (SudokuConfig xs ys zs) =
        let showThr []                 =  " "
            showThr (x:xs) | x == 0    = ("_ " ++ (showThr xs))
                           | otherwise = ((show x) ++ " " ++ (showThr xs))
            showLine [] = "" 
            showLine xs = ((showThr (take 3 xs)) ++ (showLine (drop 3 xs)))
            showThrLine []     = ""
            showThrLine (x:xs) = ((showLine x) ++ "\n"  ++ (showThrLine xs))
            showPuzzle [] = ""
            showPuzzle xs = ("\n" ++ (showThrLine (take 3 xs)) ++ (showPuzzle (drop 3 xs)))
        in  (showPuzzle xs)
            

sudokuConfigFromList :: [Integer] -> SudokuConfig
sudokuConfigFromList [] = error "empty puzzle"
sudokuConfigFromList xs =
    let suListX [] = []
        suListX xs = (take 9 xs):(suListX (drop 9 xs))
        suListY [] = []
        suListY xs = (head xs): (suListY (drop 9 xs))
        suListYGet []     = []
        suListYGet (x:xs) = (suListY (x:xs)):(suListYGet xs) 
        suListZ [] = []
        suListZ xs = (take 3 xs) ++ (suListZ (drop 9 xs))
        suListZGet n [] = []
        suListZGet n xs | n == 0    = (suListZ (take 27 xs)):(suListZGet 2 (drop 21 xs))
                        | otherwise = (suListZ (take 27 xs)):(suListZGet (n - 1) (drop 3 xs))
    in  (SudokuConfig (suListX xs) (take 9 (suListYGet xs)) (take 9 (suListZGet 2 xs)))

listFromSudokuConfig :: SudokuConfig -> [Integer]
listFromSudokuConfig (SudokuConfig [] _ _) = error "empty puzzle"
listFromSudokuConfig (SudokuConfig xs _ _) =
    let listSu []     = []
        listSu (x:xs) = x ++ (listSu xs)
    in  listSu xs

replaceZeros :: [Integer] -> [Integer] -> [[Integer]]
replaceZeros zs []                 = []
replaceZeros zs (x:xs) | x == 0    = nub [ y:ys | y <- [1..9], not (elem y zs),
                                        ys <- xs:(replaceZeros (y:zs) xs)]
                       | otherwise = nub [ x:ys | ys <- xs:(replaceZeros zs xs)]

noMatch :: [[Integer]] -> [Integer] -> Bool 
noMatch [] _     = True
noMatch xs y = 
    let notHere _ []                      = True
        notHere [] _                      = True
        notHere (y:ys) (x:xs) | y == x    = False
                              | otherwise = notHere ys xs
        remain _ []                   = True
        remain [] _                   = True
        remain y (x:xs) | notHere y x = True
                        | otherwise   = False
    in (remain y xs)-- && (noMatch xs y)

replaceRow :: [Integer] -> [[Integer]]
replaceRow [] = []
replaceRow x  = [ y | y <- replaceZeros x x, not (elem 0 y)]

replaceRows :: [[Integer]] -> [[[Integer]]]
replaceRows [] = []
replaceRows (x:xs) = 
    let row = [ y | y <- replaceRow x]
    in row:(replaceRows xs)

instance Config SudokuConfig where
    successors (SudokuConfig xs ys zs) = 
        let [x1',x2',x3',x4',x5',x6',x7',x8',x9'] = replaceRows xs
        in  [SudokuConfig [x1,x2,x3,x4,x5,x6,x7,x8,x9] ys zs |
            x1 <- x1', x2 <- x2', x3 <- x3', x4 <- x4', x5 <- x5',
            x6 <- x6', x7 <- x7', x8 <- x8', x9 <- x9']
 
    isGoal (SudokuConfig xs ys zs) = 
        let noDup ys []     = True
            noDup ys (x:xs) = (not (elem x ys)) && (noDup ys xs)
            checkRows []        = True
            checkRows (x:xs) = (noDup x x) && (checkRows xs)
        in checkRows xs

sudokuSolve :: SudokuConfig -> (Maybe SudokuConfig)
sudokuSolve x = solve x
