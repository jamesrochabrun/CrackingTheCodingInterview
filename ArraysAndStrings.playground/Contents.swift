//: Playground - noun: a place where people can play

import UIKit

// CHAPTER 1 Arrays and Strings

// extra:  1 check if the items of two arrays can be summed and match at least the value of the target value
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

// 2 extra: isPalindrome
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

// 3 extra: Find all Backwards Read Primes between two positive given numbers (both inclusive), the second one being greater than the first one. The resulting array or the resulting string will be ordered following the natural order of the prime numbers.

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
    func isPermutable(with newString: String, charSensitive: Bool = false) -> Bool {
        return charSensitive ? (self.lowercased().sorted() == newString.lowercased().sorted()) : (self.sorted() == newString.sorted())
    }
}

let testPermuted = "abcD".isPermutable(with: "cbda", charSensitive: true)


// 1.3 URLfy write a method to replace all spaces in a string with %20

// Example
// Input: "MR jon Smith   ", 13
//Output "Mr%20JonSmith

extension String {
    
    var urlFYString: String {
        let words = self.split(separator: " ")
        var urlFy = ""
        let wordsEndIndex = words.count - 1
        for word in 0...wordsEndIndex  {
            if wordsEndIndex == word {
                urlFy += words[word]
            } else {
                urlFy += words[word] + "%20"
            }
        }
        return urlFy
    }
}

let urlFy = "MR jon Smith   ".urlFYString

// 1.4 Palindrome permutations Given a string write a function to check if its permutation of a palindrome

// dividing in two steps, first find if string its palindrome
extension String {
    
    var isPal: Bool {
        let mapText = self.map { $0.description }
        var isPal = false
        let maxBounds = mapText.count - 1
        for i in 0...maxBounds {
            if mapText[i] == mapText[maxBounds - i] {
                isPal = true
            } else {
                isPal = false
                break
            }
        }
        return isPal
    }
    
    func isPermutationOfAPalindrome(_ value: String) -> Bool {
        guard self.isPal else { return false }
        return self.isPermutable(with: value)
    }
    
    func getIndexOf(value: Int, in array: [Int]) -> Int {
        
        var leftIndex = 0
        var rightIndex = array.count - 1
        
        while leftIndex <= rightIndex {
            
            let middleIndex = (leftIndex + rightIndex) / 2
            let middleValue = array[middleIndex]
            
            if middleValue == value {
                return middleIndex
            }
            if value < middleValue {
                rightIndex = middleIndex - 1
            }
            if value > middleValue {
                leftIndex = middleIndex + 1
            }
        }
        return 0
    }
  
}

extension Array {
    
    func indexOfInSortedArray<T: Comparable>(_ item: T) -> Int {
        
        var leftIndex = 0
        var rightIndex = self.count - 1
        
        while leftIndex <= rightIndex {
            
            let middleIndex = (leftIndex + rightIndex) / 2
            let middleValue: T = self[middleIndex] as! T
            
            if middleValue == item {
                return middleIndex // the index or the value = middleValue || true
            }
            if item < middleValue {
                rightIndex = middleIndex - 1
            }
            if item > middleValue {
                leftIndex = middleIndex + 1
            }
        }
        return 0
    }
}

// 1.5 there are 3 types of edit in a string - insert, remove or replace, write a function that compares if two string are one "edit" away from each other or zero edit

/// EXample pale -> ple = true
/// pales -> pale = true
/// pale -> bale = true
/// pale -> bake = false // two edit

func isEdited(str1: String, with str2: String) -> Bool {
    
    let arrStr1 =  str1.map{$0.description}
    let arrStr2 = str2.map{$0.description}
    /// logic:
    // a) if a character has been inserted to the string means that the string count is +1
    // b) if a character has been inserted to the string means that the string count is +1
    // c) if a character has been replaced from a string means that the count is the same

    /// common elements will be always x
    let commonElements = Array(Set(arrStr1).intersection(Set(arrStr2)))
    /// substracting x - the longest string will return the number of inconsistencies between both strings
    let maxLenght = max(arrStr1.count, arrStr2.count)
    /// if the abs value is not 1 means that can be greater than 1 or 0 for equal strings
    return abs(commonElements.count - maxLenght) == 1
}

isEdited(str1: "pales", with: "pale")

// 1.6 String compression, implement a method to perform basic string compression, using the counts of repeated characters.
// Example: aabcccccaaa should return a2b1c5a3
// if the "compressed" string would not become smaller than the original string, your method should return the original string.

/// step 1 create a String Builder, concatenation of strings in a for loop is 0(n square) lets append a character to an array instead

struct StringBuilder {
    
    var characters: [String]
    
    init(characters: [String]) {
        self.characters = characters
    }
    
    var count: Int {
        return characters.count
    }
    
    var toString: String {
        return characters.joined()
    }
}

/// Setp 2 Create an extension of String to be able to subscript
extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

/// Step 3 build the function
func compress(string: String) -> String {
    
    var compressed = StringBuilder(characters: [])
    var countConsecutive: Int = 0
    
    for i in 0..<string.count {
        countConsecutive += 1
        // if next character is different than current, append this char to result
        if i + 1 >= string.count  || string[i] != string[i + 1] {
            compressed.characters.append("\(string[i])")
            compressed.characters.append("\(countConsecutive)")
            countConsecutive = 0
        }
    }
    return compressed.count < string.count ? compressed.toString : string
}


print(compress(string: "aabcccccaaa"))










