//: Playground - noun: a place where people can play

import UIKit

// 1 check if the items of two arrays can be summed and match at least the value of the target value

func sumArraysItems(_ arrayA: [Int], arrayB: [Int], toMatchAtLeast targetValue: Int) -> Bool {
    
    /// both arrays needs to have same length
    guard arrayA.count == arrayB.count else { return false }
    
   /// sort array A ascending
    let arrA = arrayA.sorted { $0 < $1 }
    /// sort array B descending
    let arrB = arrayB.sorted { $0 > $1 }
    /// compare if the A(i) + B(i) >= targetValue
    var isValid = false
    
    for i in 0..<arrA.count {
        if arrA[i] + arrB[i] >= targetValue {
            isValid = true
        } else {
            isValid = false
            break
        }
    }
    return isValid
}

let arrA = [2, 3, 7, 3] // 2, 3, 3, 7
let arrB = [5, 4, 1, 2] // 5, 4, 2, 1
let targetValue = 5

let isValid = sumArraysItems(arrA, arrayB: arrB, toMatchAtLeast: targetValue)
//print(isValid)

// 2 isPalindrome
extension String {
    
    var isPalindrome: Bool {
        let textArray = self.map { $0.description.lowercased() }
        var isP = false
        for i in 0..<textArray.count {
            if textArray[i] == textArray[textArray.count - 1 - i] {
                isP = true
            } else {
                isP = false
                break
            }
        }
        return isP
    }
}

let textTest = "robor".isPalindrome
//print("isP = \(textTest)")

// 3 Find all Backwards Read Primes between two positive given numbers (both inclusive), the second one being greater than the first one. The resulting array or the resulting string will be ordered following the natural order of the prime numbers.

extension Int {
    
    var reversed: Int? {
        let strInt = "\(self)"
        let reversedArray = strInt.map { $0.description }.reversed()
        let reversedStr = reversedArray.joined()
        return Int(reversedStr)
    }
}

/// challenge Backward read primes
func backwardsPrime(_ start: Int, _ stop: Int) -> [Int] {
    /// create an array from start and stop range
    /// get all prime numbers in range
    let primeNumbersAndReversed = Array(start...stop).filter { isPalindromePrime($0) }
    /// compare reversed
    return primeNumbersAndReversed
}

func isPrime(_ number: Int) -> Bool {
    return number > 1 && !(2..<(Int(sqrt(Double(number))) + 1)).contains { number % $0 == 0 }
}

func isPalindromePrime(_ number: Int) -> Bool {
    return isPrime(number) && isPrime(number.reversed!)
}

if backwardsPrime(9900, 10000) == [9923, 9931, 9941, 9967] {
    //print("yes!")
} else {
   // print(backwardsPrime(9900, 10000))
}

/// Interview Questions

// 1.1 isUnique - check if a string has all unique characters
extension String {
    
    /// ASK: does the string is ASCII or Unicode String
    /// using a hashtable
    var isUnique: Bool {
        let textArray = self.map { $0.description }
        var dict: [String: Bool] = [:]
        for char in textArray {
            if let exists = dict[char], exists {
                return false
            }
            dict[char] = true
        }
        return true
    }
    
    /// using a set
    var isUniqueSet: Bool {
        let textArray = self.map { $0.description }
        let set = Set.init(textArray)
        return set.count == textArray.count
    }
}

let test = "abc".isUnique
print("t = \(test)")

// 1.2 check Permutation - Given two strings write a method to decide if one is a permutation of the other

/// ASK: does the check is case sensitive
/// does white space is significant

extension String {
    
    func isPermutable(with newString: String, cahracterSensitive: Bool = false) -> Bool {
        return cahracterSensitive ? (self.lowercased().sorted() == newString.lowercased().sorted()) : (self.sorted() == newString.sorted())
    }
}

let testPermuted = "abcD".isPermutable(with: "cbda", cahracterSensitive: true)













