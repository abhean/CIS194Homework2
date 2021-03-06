{-# OPTIONS_GHC -Wall #-}
module HW02 where

-- Mastermind -----------------------------------------

-- A peg can be one of six colors
data Peg = Red | Green | Blue | Yellow | Orange | Purple
         deriving (Show, Eq, Ord)

-- A code is defined to simply be a list of Pegs
type Code = [Peg]

-- A move is constructed using a Code and two integers; the number of
-- exact matches and the number of regular matches
data Move = Move Code Int Int
          deriving (Show, Eq)

-- List containing all of the different Pegs
colors :: [Peg]
colors = [Red, Green, Blue, Yellow, Orange, Purple]

-- Exercise 1 -----------------------------------------

-- Get the number of exact matches between the actual code and the guess
exactMatches :: Code -> Code -> Int
exactMatches [] _ = 0
exactMatches _ [] = 0
exactMatches (x:xs) (y:ys) = (if x == y then 1 else 0) + exactMatches xs ys

-- Exercise 2 -----------------------------------------

-- For each peg in xs, count how many times is occurs in ys
countColors :: Code -> [Int]
-- NOTE[egarcia]: This seems to be O(n2) when it should be O(n). Should I index a colors table by enum value index? how?
countColors code = map (`countColor` code) colors

countColor :: Peg -> Code -> Int
countColor colorToCount = length . filter (==colorToCount)

-- Count number of matches between the actual code and the guess
matches :: Code -> Code -> Int
matches code1 code2 = sum $ zipWith min (countColors code1) (countColors code2)

-- Exercise 3 -----------------------------------------

-- Construct a Move from a guess given the actual code
getMove :: Code -> Code -> Move
getMove secretCode guessCode = Move guessCode numExactMatches (numTotalMatches - numExactMatches)
    where numExactMatches = exactMatches secretCode guessCode
          numTotalMatches = matches secretCode guessCode

-- Exercise 4 -----------------------------------------

isConsistent :: Move -> Code -> Bool
isConsistent move@(Move guessCode _ _) secretCode = move == getMove secretCode guessCode

-- Exercise 5 -----------------------------------------

filterCodes :: Move -> [Code] -> [Code]
filterCodes move = filter (isConsistent move)

-- Exercise 6 -----------------------------------------

allCodes :: Int -> [Code]
allCodes 0 = [[]]
allCodes n = [color:code | color <- colors, code <- allCodes (n - 1)]

-- Exercise 7 -----------------------------------------

solve :: Code -> [Move]
solve = undefined

-- Bonus ----------------------------------------------

fiveGuess :: Code -> [Move]
fiveGuess = undefined
