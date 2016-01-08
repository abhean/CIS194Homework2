module Main where

import HW02Tests
import HW02
import Testing

main = print . runTests . concat $ [ex1Tests, ex2Tests]