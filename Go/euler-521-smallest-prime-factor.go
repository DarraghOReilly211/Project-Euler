package main

import (
	"fmt"
	"math"
)

// Function to find the smallest prime factor of n
func smallestPrimeFactor(n int64) int64 {
	if n%2 == 0 {
		return 2
	}
	limit := int64(math.Sqrt(float64(n))) + 1
	for i := int64(3); i <= limit; i += 2 {
		if n%i == 0 {
			return i
		}
	}
	return n
}

// Function to calculate S(n) mod mod
func S(n int64, mod int64) int64 {
	sum := int64(0)
	for i := int64(2); i <= n; i++ {
		sum = (sum + smallestPrimeFactor(i)) % mod
	}
	return sum
}

func main() {
	n := int64(math.Pow(10, 12)) // 10^12
	mod := int64(1000000000)     // 10^9
	fmt.Println("S(10^12) mod 10^9 =", S(n, mod))
}
