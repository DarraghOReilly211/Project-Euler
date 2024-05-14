package main

import (
	"fmt"
	"math/big"
)

// Function to destroy the last item in a list
func destroyLastItem(list []*big.Int) []*big.Int {
	if len(list) == 0 {
		return list // return the list as is if it's empty
	}
	return list[:len(list)-1] // return the list with the last item removed
}

func FNoMod(m, n int) int {

	set := make(map[int]bool)
	if m == 2 {
		for i := 1; i < n+1; i++ {
			set[2*i] = true
		}
		set[1] = true
	} else if m == 1 {
		set[1] = true
	} else {
		nList := make([]*big.Int, n)

		if n != 1 {
			for i := 0; i < n; i++ {
				nList[i] = big.NewInt(int64(m))
			}
		} else {
			for i := 1; i < m+1; i++ {
				set[i] = true
			}
		}

		mod := big.NewInt(1000000007)
		var numIterations int = 1 + ((m - 1) * (n - 1))
		var currentIteration int = 0
		var lastNList int = n - 1

		for i := 0; i < numIterations; i++ {
			nList[0] = big.NewInt(int64(m - currentIteration))
			for j := 0; j < (m - currentIteration); j++ {

				result := big.NewInt(1)
				if len(nList) == 1 {
					for k := 0; k < m; k++ {
						set[k+1] = true
					}
				} else if currentIteration == m-1 {
					for k := 0; k < len(nList); k++ {
						result.Mul(result, nList[k])
						result.Mod(result, mod)
						set[int(result.Int64())] = true
					}
					nList = destroyLastItem(nList)
					currentIteration = 1

					lastNList = (len(nList) - 1)
					nList[0] = big.NewInt(int64(m))
				} else if currentIteration == 0 {
					for k := 0; k < len(nList); k++ {
						result.Mul(result, nList[k])
						result.Mod(result, mod)
						set[int(result.Int64())] = true
					}
					nList[0].Sub(nList[0], big.NewInt(1))

				} else {
					for k := 0; k < len(nList); k++ {
						result.Mul(result, nList[k])
						result.Mod(result, mod)
						set[int(result.Int64())] = true
					}
					nList[0].Sub(nList[0], big.NewInt(1))

				}
			}
			nList[lastNList].Sub(nList[lastNList], big.NewInt(1))
			currentIteration += 1
		}
	}

	return len(set)
}

func main() {
	var m, n int
	fmt.Printf("Please input m and n: \n")
	fmt.Scan(&m, &n)

	// Create a memoization table

	fmt.Println(FNoMod(m, n))
}
