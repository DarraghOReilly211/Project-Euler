import Data.List (group)
import System.Environment (getArgs)
import qualified Data.Map as Map


-- Sieve of Eratosthenes to generate primes
primes :: [Integer]
primes = 2 : filter (isPrime primes) [3,5..]
  where
    isPrime (p:ps) n = p*p > n || n `mod` p /= 0 && isPrime ps n

-- Function to calculate the number of divisors of n
d :: Integer -> Map.Map Integer Integer -> (Integer, Map.Map Integer Integer)
d n cache =
  case Map.lookup n cache of
    Just res -> (res, cache)
    Nothing  -> let res = divisorCount n
                in (res, Map.insert n res cache)
  where
    divisorCount n = product . map ((+1) . fromIntegral . length) . group . primeFactors $ n
    primeFactors n = factorize n primes
    factorize n (p:ps) 
      | p*p > n    = [n]
      | n `mod` p == 0 = p : factorize (n `div` p) (p:ps)
      | otherwise  = factorize n ps

-- Function M(n, k)
m :: Integer -> Integer -> Map.Map Integer Integer -> (Integer, Map.Map Integer Integer)
m n k cache = foldl (\(maxD, c) j -> let (dj, c') = d j c in (max maxD dj, c')) (0, cache) [n..n+k-1]

-- Function S(u, k)
s :: Integer -> Integer -> Integer
s u k = fst $ foldl (\(sumM, c) n -> let (mn, c') = m n k c in (sumM + mn, c')) (0, Map.empty) [1..u-k+1]

-- Main function to accept command line arguments
main :: IO ()
main = do
    args <- getArgs
    let u = read (args !! 0) :: Integer
    let k = read (args !! 1) :: Integer
    print $ s u k