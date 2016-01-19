module Main where

import HW02Tests
import HW02
import Testing

main = do
        print . runTests . concat $ [ex1Tests, ex2Tests, ex3Tests, ex4Tests, ex5Tests, ex6Tests, ex7Tests]

