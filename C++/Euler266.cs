using System;
using System.Numerics;

class Program
{
    static void Main(string[] args)
    {
        if (args.Length < 1)
        {
            Console.WriteLine("Usage: dotnet run n");
            return;
        }

        // Parse the command line argument
        int n;
        if (!int.TryParse(args[0], out n))
        {
            Console.WriteLine("Error converting n to integer.");
            return;
        }

        // Hardcoded primes list
        int[] primes = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191 };

        // Calculate the product of primes below n
        BigInteger product = ProductOfPrimesBelow(n, primes);

        // Calculate the pseudo square root of the product
        BigInteger psr = FindPSR(product);

        Console.WriteLine($"The PSR of the product of primes below {n} is: {psr}");
    }

    // Calculates the product of all primes less than n
    static BigInteger ProductOfPrimesBelow(int n, int[] primes)
    {
        BigInteger product = 1;
        foreach (int prime in primes)
        {
            if (prime >= n)
                break;
            product *= prime;
        }
        return product;
    }

    // Builds a list of divisors of n that are less than or equal to the square root of n
    static BigInteger[] BuildDividers(BigInteger n)
    {
        BigInteger sqrtN = Sqrt(n);
        var dividers = new System.Collections.Generic.List<BigInteger>();

        // Check for even divisors first
        if (n % 2 == 0)
            dividers.Add(2);

        // Iterate from 3 to sqrtN, checking for divisors
        for (BigInteger i = 3; i <= sqrtN; i += 2)
        {
            if (n % i == 0)
                dividers.Add(i);
        }

        return dividers.ToArray();
    }

    // Finds the largest divisor of n that is less than or equal to the square root of n
    static BigInteger FindPSR(BigInteger n)
    {
        BigInteger sqrtN = Sqrt(n);
        BigInteger[] dividers = BuildDividers(n);
        BigInteger pseudoRoot = 0;

        foreach (BigInteger divider in dividers)
        {
            if (divider <= sqrtN)
                pseudoRoot = divider;
        }

        return pseudoRoot;
    }

    // Calculates the square root of a BigInteger
    static BigInteger Sqrt(BigInteger n)
    {
        if (n == 0) return 0;
        BigInteger a = (n / 2) + 1;
        BigInteger b = (a + (n / a)) / 2;

        while (b < a)
        {
            a = b;
            b = (a + (n / a)) / 2;
        }

        return a;
    }
}
