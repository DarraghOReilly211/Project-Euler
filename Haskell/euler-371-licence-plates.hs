{-

Oregon licence plates consist of three letters followed by a three digit number (each digit can be from [0..9]).
While driving to work Seth plays the following game:
Whenever the numbers of two licence plates seen on his trip add to 1000 that's a win.

E.g. MIC-012 and HAN-988 is a win and RYU-500 and SET-500 too (as long as he sees them in the same trip).

Find the expected number of plates he needs to see for a win.
Give your answer rounded to 8 decimal places behind the decimal point.

Note: We assume that each licence plate seen is equally likely to have any three digit number on it.


We used 'https://trinket.io/python/4b474c1a78' for the logic behind the program -}


import System.Environment (getArgs)
import Text.Printf (printf)

-- Function to calculate the expected number of plates
expectedPlates :: Int -> Double
expectedPlates t = go (fromIntegral t / 4) 0 0
  -- Recursive helper function for calculation
  where
    go :: Double -> Double -> Double -> Double
    go i e0 e1
      | i < 0 = e0
      | otherwise =
        let newE1 = (fromIntegral t + (fromIntegral (t - 2) - 2 * i) * e1) / fromIntegral (t - round i - 1)
            newE0 = (fromIntegral t + (fromIntegral (t - 2) - 2 * i) * e0 + newE1) / fromIntegral (t - round i - 1)
        in go (i - 1) newE0 newE1

-- Main function handling command-line arguments and output
main :: IO ()
main = do
  args <- getArgs
  case args of
    [input] -> do
      let t = read input :: Int
          result = expectedPlates t
      printf "Expected number of plates: %.8f\n" result
    _ -> putStrLn "Enter the total count of plates as a command-line argument"