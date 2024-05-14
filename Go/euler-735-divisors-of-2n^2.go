package main

import (
	"fmt"
)

func countDivisors(n int64) int64 {
	var count int64 = 0
	for i := int64(1); i <= n; i++ {
		if (2*n*n)%i == 0 {
			count++
		}
	}
	return count
}

func main() {
	N := int64(1000)
	var sum int64 = 0

	for n := int64(1); n <= N; n++ {
		sum += countDivisors(n)
	}

	fmt.Println("F(", N, ") =", sum)
}
