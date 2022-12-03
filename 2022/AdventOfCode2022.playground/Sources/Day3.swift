import Foundation

public class Day3: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let rucksacks = string.components(separatedBy: "\n").dropLast()
        var sum1 = 0
        for rucksack in rucksacks {
            let c1 = Set(rucksack.prefix(rucksack.count/2))
            let c2 = Set(rucksack.suffix(rucksack.count/2))
            guard let commonLetter = c1.intersection(c2).first else { continue }
            guard let value = values[String(commonLetter)] else { continue }
            sum1 += value
        }
        print(sum1)
        var sum2 = 0
        var i = 0
        while i < rucksacks.count {
            let r1 = Set(rucksacks[i])
            let r2 = Set(rucksacks[i+1])
            let r3 = Set(rucksacks[i+2])
            guard let commonLetter = r1.intersection(r2).intersection(r3).first else { continue }
            guard let value = values[String(commonLetter)] else { continue }
            sum2 += value
            i += 3
        }
        print(sum2)
    }
}

let values: [String: Int] = [
    "a": 1,
    "b": 2,
    "c": 3,
    "d": 4,
    "e": 5,
    "f": 6,
    "g": 7,
    "h": 8,
    "i": 9,
    "j": 10,
    "k": 11,
    "l": 12,
    "m": 13,
    "n": 14,
    "o": 15,
    "p": 16,
    "q": 17,
    "r": 18,
    "s": 19,
    "t": 20,
    "u": 21,
    "v": 22,
    "w": 23,
    "x": 24,
    "y": 25,
    "z": 26,
    "A": 27,
    "B": 28,
    "C": 29,
    "D": 30,
    "E": 31,
    "F": 32,
    "G": 33,
    "H": 34,
    "I": 35,
    "J": 36,
    "K": 37,
    "L": 38,
    "M": 39,
    "N": 40,
    "O": 41,
    "P": 42,
    "Q": 43,
    "R": 44,
    "S": 45,
    "T": 46,
    "U": 47,
    "V": 48,
    "W": 49,
    "X": 50,
    "Y": 51,
    "Z": 52
]
