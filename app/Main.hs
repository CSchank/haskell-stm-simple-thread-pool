module Main where

import Lib
import System.Environment
import Text.Read (readMaybe)

main :: IO ()
main = do
    args <- getArgs
    case map readMaybe args of 
        [Just n0,Just n1] -> startWorkers n0 n1
        _ -> putStrLn "Usage: stack exec haskell-stm-simple-thread-pool-exe <workers> <tasks>"

