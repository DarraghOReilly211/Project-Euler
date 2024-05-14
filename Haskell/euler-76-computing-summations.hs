import System.Environment (getArgs)
import Data.Array

change :: Integer -> Integer
change t = cache ! (t, 99)
  where
    -- Create a 2D array 'cache' to store results using an array from Data.Array
    cache = array ((0, 0), (t, 99)) [((i, j), f i j) | i <- [0..t], j <- [0..99]]

    -- Helper function 'f' to calculate change recursively
    f :: Integer -> Integer -> Integer
    f _ 1 = 1
    f t' c' = sum [cache ! (t' - i * c', c' - 1) | i <- [0..t' `quot` c']]

-- command-line arguments and output the result
main :: IO ()
main = do
  args <- getArgs
  case args of
    [t] -> do
      let target = read t :: Integer
          result = change target
      -- Output the calculated 'result'
      putStrLn $ show result
    _ -> putStrLn "Usage: ./computing_summations <target>"
