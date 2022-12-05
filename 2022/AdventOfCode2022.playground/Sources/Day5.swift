import Foundation

// Starting Configuration
// ----------------------
//             [J]             [B] [W]
//             [T]     [W] [F] [R] [Z]
//         [Q] [M]     [J] [R] [W] [H]
//     [F] [L] [P]     [R] [N] [Z] [G]
// [F] [M] [S] [Q]     [M] [P] [S] [C]
// [L] [V] [R] [V] [W] [P] [C] [P] [J]
// [M] [Z] [V] [S] [S] [V] [Q] [H] [M]
// [W] [B] [H] [F] [L] [F] [J] [V] [B]
// 1   2   3   4   5   6   7   8   9

var dictionary: [Int: [String]] = [
    1: ["W", "M", "L", "F"],
    2: ["B", "Z", "V", "M", "F"],
    3: ["H", "V", "R", "S", "L", "Q"],
    4: ["F", "S", "V", "Q", "P", "M", "T", "J"],
    5: ["L", "S", "W"],
    6: ["F", "V", "P", "M", "R", "J", "W"],
    7: ["J", "Q", "C", "P", "N", "R", "F"],
    8: ["V", "H", "P", "S", "Z", "W", "R", "B"],
    9: ["B", "M", "J", "C", "G", "H", "Z", "W"],
]

public class Day5: Day {
    public static func run() {
        let partOne: Bool = true
        guard let string = getInputString() else { exit(0) }
        let lines = string.components(separatedBy: "\n").dropLast()
        for line in lines {
            let components = line.components(separatedBy: ["move ", " from ", " to "]).compactMap { Int($0) }
            let numberToMove = components[0]
            let fromStackIndex = components[1]
            let toStackIndex = components[2]
            if partOne {
                for _ in 1...numberToMove {
                    guard let topItem = dictionary[fromStackIndex]?.last else { continue }
                    dictionary[toStackIndex]?.append(topItem)
                    dictionary[fromStackIndex] = dictionary[fromStackIndex]?.dropLast()
                }
            } else {
                guard let fromStackCrates = dictionary[fromStackIndex] else { continue }
                let cratesToMove = fromStackCrates[(fromStackCrates.count-numberToMove)..<fromStackCrates.count]
                dictionary[toStackIndex]?.append(contentsOf: cratesToMove)
                dictionary[fromStackIndex] = dictionary[fromStackIndex]?.dropLast(numberToMove)
            }
        }
        var topCrates = ""
        for i in 1...9 {
            guard let topCrate = dictionary[i]?.last else { continue }
            topCrates.append(topCrate)
        }
        print(topCrates)
    }
}

extension String {
    public func components(separatedBy separators: [String]) -> [String] {
        var output: [String] = [self]
        for separator in separators {
            output = output.flatMap { $0.components(separatedBy: separator) }
        }
        return output.map { $0.trimmingCharacters(in: .whitespaces)}
    }
}
