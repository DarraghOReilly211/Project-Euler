package main

import (
	"fmt"
	"math/big"
)

// generatePrimes returns a slice of prime numbers less than or equal to n.
func generatePrimes(n int) []int {
	prime := make([]bool, n+1)
	for i := 2; i <= n; i++ {
		prime[i] = true
	}

	for p := 2; p*p <= n; p++ {
		if prime[p] {
			for i := p * p; i <= n; i += p {
				prime[i] = false
			}
		}
	}

	var primes []int
	for p := 2; p <= n; p++ {
		if prime[p] {
			primes = append(primes, p)
		}
	}

	return primes
}

func productOfPrimesBelow(primes []int, modulus *big.Int) *big.Int {
	product := big.NewInt(1)
	for _, prime := range primes {
		product.Mul(product, big.NewInt(int64(prime))).Mod(product, modulus)
	}
	return product
}

// findPSR finds the Pseudo Square Root of a given big.Int number.
func findPSR(n *big.Int) *big.Int {
	// Starting from 2, find the largest divisor that does not exceed the square root of n
	divisor := big.NewInt(2)
	root := new(big.Int).Sqrt(n)
	one := big.NewInt(1)

	for ; divisor.Cmp(root) <= 0; divisor.Add(divisor, one) {
		if new(big.Int).Mod(n, divisor).Cmp(big.NewInt(0)) == 0 {
			// Found a divisor, continue to find larger ones until the square root is reached
		}
	}

	// The divisor now is greater than the square root, so we return the previous one
	return divisor.Sub(divisor, one)
}

func main() {
	var n int
	fmt.Print("Please input n: ")
	fmt.Scan(&n)
	primes := generatePrimes(n)
	modulus := big.NewInt(0).Exp(big.NewInt(10), big.NewInt(16), nil)
	product := productOfPrimesBelow(primes, modulus)

	psr := findPSR(product) // Consider optimizing this function as well

	// No need to apply modulus again here
	fmt.Printf("The PSR of the product of primes below %d is: %s\n", n, psr.String())
}
