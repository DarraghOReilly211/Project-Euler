{-The series, 1^1+2^2+3^3+⋯+10^10=10405071317
Find the last ten digits of the series, 1^1+2^2+3^3+⋯+1000^1000-}


import System.Environment (getArgs)
import Data.Char (digitToInt)
import Data.List (foldl')

-- Function to calculate the last ten digits of the series
lastTenDigits :: Integer -> Integer
 -- Utilizes a left fold operation to sum the series of x^x `mod` 10^10 for each x from 1 to n
lastTenDigits n = foldl' (\acc x -> (acc + x) `mod` 10^10) 0 [x^x `mod` 10^10 | x <- [1..n]]

-- Convert a string to an integer
stringToInt :: String -> Integer
stringToInt = read

-- main section that retrieves input from the user and uses it in the function
main :: IO ()
main = do
    args <- getArgs
    case args of
        [input] -> do
            let num = stringToInt input
                result = lastTenDigits num
            print result  
        _ -> putStrLn "Please provide a single number as an argument"