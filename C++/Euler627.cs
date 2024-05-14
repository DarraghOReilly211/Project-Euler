using System;
using System.Collections.Generic;
using System.Numerics;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Please input m and n: ");
        int m = Convert.ToInt32(Console.ReadLine());
        int n = Convert.ToInt32(Console.ReadLine());

        Console.WriteLine(FNoMod(m, n));
    }

    static List<BigInteger> DestroyLastItem(List<BigInteger> list)
    {
        if (list.Count == 0)
        {
            return list;
        }
        list.RemoveAt(list.Count - 1);
        return list;
    }

    static int FNoMod(int m, int n)
    {
        var set = new Dictionary<int, bool>();
        if (m == 2)
        {
            for (int i = 1; i <= n; i++)
            {
                set[2 * i] = true;
            }
            set[1] = true;
        }
        else if (m == 1)
        {
            set[1] = true;
        }
        else
        {
            var nList = new List<BigInteger>(new BigInteger[n]);

            if (n != 1)
            {
                for (int i = 0; i < n; i++)
                {
                    nList[i] = new BigInteger(m);
                }
            }
            else
            {
                for (int i = 1; i <= m; i++)
                {
                    set[i] = true;
                }
            }

            BigInteger mod = new BigInteger(1000000007);
            int numIterations = 1 + ((m - 1) * (n - 1));
            int currentIteration = 0;
            int lastNList = n - 1;

            for (int i = 0; i < numIterations; i++)
            {
                nList[0] = new BigInteger(m - currentIteration);
                for (int j = 0; j < (m - currentIteration); j++)
                {
                    BigInteger result = new BigInteger(1);
                    if (nList.Count == 1)
                    {
                        for (int k = 0; k < m; k++)
                        {
                            set[k + 1] = true;
                        }
                    }
                    else if (currentIteration == m - 1)
                    {
                        for (int k = 0; k < nList.Count; k++)
                        {
                            result *= nList[k];
                            result %= mod;
                            set[(int)result] = true;
                        }
                        nList = DestroyLastItem(nList);
                        currentIteration = 1;

                        lastNList = nList.Count - 1;
                        nList[0] = new BigInteger(m);
                    }
                    else if (currentIteration == 0)
                    {
                        for (int k = 0; k < nList.Count; k++)
                        {
                            result *= nList[k];
                            result %= mod;
                            set[(int)result] = true;
                        }
                        nList[0] -= 1;
                    }
                    else
                    {
                        for (int k = 0; k < nList.Count; k++)
                        {
                            result *= nList[k];
                            result %= mod;
                            set[(int)result] = true;
                        }
                        nList[0] -= 1;
                    }
                }
                nList[lastNList] -= 1;
                currentIteration++;
            }
        }

        return set.Count;
    }
}
