using System;

class Program
{
    // Function to find the smallest prime factor of n
    static long SmallestPrimeFactor(long n)
    {
        // Handle even numbers
        if (n % 2 == 0)
        {
            return 2;
        }
        // Handle odd numbers
        // Set up the limit for the loop, as we don't need to go past the square root
        // to find the lowest prime factor. If the lowest prime factor is greater than the square root,
        // then the number is prime and the number itself is the lowest prime factor.
        long limit = (long)Math.Sqrt(n) + 1;
        // Loop through all odd numbers from 3 to limit
        for (long i = 3; i <= limit; i += 2)
        {
            if (n % i == 0)
            {
                return i;
            }
        }
        return n;
    }

    // Function to calculate S(n) mod mod
    static long S(long n)
    {
        // Setting up the modulus for the problem
        long mod = (long)Math.Pow(10, 9);
        // Setting up sum to start calculations
        long sum = 0;
        // Loop through all numbers from 2 to n
        for (long i = 2; i <= n; i++)
        {
            sum = (sum + SmallestPrimeFactor(i)) % mod;
        }
        return sum;
    }

    static void Main(string[] args)
    {
        // Check for proper command line arguments
        if (args.Length < 1)
        {
            Console.WriteLine("Usage: Program.exe n");
            return;
        }

        // Convert command line argument[0] to integer n
        if (!long.TryParse(args[0], out long n))
        {
            Console.WriteLine("Error converting n to integer");
            return;
        }

        // Print the result from function S()
        Console.WriteLine(S(n));
    }
}
