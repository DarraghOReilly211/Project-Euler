import Data.Char (digitToInt)
import Data.List (findIndices)
import System.Environment (getArgs)
import Text.Read (readMaybe) 

-- Check if a number is a valid 123-number
is123Number :: Int -> Bool
is123Number 1 = True
is123Number 2 = True
is123Number 3 = True
is123Number n
  | n > 3 = let digits = map digitToInt $ show n
                validDigits = all (`elem` [1, 2, 3]) digits
                counts = map (\d -> length $ findIndices (== d) digits) digits
            in validDigits && all is123Number counts
  | otherwise = False

-- Generate the sequence of 123-numbers up to the N-th number
find123Number :: Int -> Maybe Int
find123Number n = 
  let upperLimit = 1000  -- Arbitrary upper limit for brute force approach
      sequence123 = filter is123Number [1..upperLimit]
  in if length sequence123 >= n then Just (sequence123 !! (n - 1)) else Nothing

-- Modulo operation
modulo :: Int -> Int
modulo number = number `mod` 123123123

-- Main function
main :: IO ()
main = do
  args <- getArgs
  case args of
    [arg] -> case readMaybe arg of
               Just n -> case find123Number n of
                           Just number -> print $ modulo number
                           Nothing -> putStrLn "Error: Unable to find the 123-number."
               Nothing -> putStrLn "Error: Invalid input. Please enter a valid number."
    _ -> putStrLn "Usage: Euler698 <n>"
