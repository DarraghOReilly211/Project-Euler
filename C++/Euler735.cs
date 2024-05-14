using System;

public class DivisorCounter
{
    public static long CountDivisors(long n)
    {
        long count = 0;
        for (long i = 1; i <= n; i++)
        {
            if ((2 * n * n) % i == 0)
            {
                count++;
            }
        }
        return count;
    }

    public static void Main(string[] args)
    {
        long N = 1000;
        long sum = 0;

        for (long n = 1; n <= N; n++)
        {
            sum += CountDivisors(n);
        }

        Console.WriteLine("F(" + N + ") = " + sum);
    }
}
