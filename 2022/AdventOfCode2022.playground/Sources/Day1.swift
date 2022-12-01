import Foundation

public class Day1: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        
        // Part One
        let totalCaloriesOfEachElf = getTotalCaloriesOfEachElf(string)
        print("The elf with the most calories has \(totalCaloriesOfEachElf.max() ?? 0) calories.")
        
        // Part Two
        let totalCaloriesOfThreeElvesWithMostCalories = totalCaloriesOfEachElf
            .sorted(by: { $0 > $1 })[0...2]
            .reduce(0, +)
        print("The three elves with the most calories have a total of \(totalCaloriesOfThreeElvesWithMostCalories) calories.")
    }
    
    static func getTotalCaloriesOfEachElf(_ string: String) -> [Int] {
        let strings = string.components(separatedBy: "\n\n")
        return strings.map { string in
            return string.components(separatedBy: "\n")
                .compactMap { Int($0) }
                .reduce(0, +)
        }
    }
}
