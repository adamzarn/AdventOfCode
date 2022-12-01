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
    
    public static func runFaster() {
        guard let string = getInputString() else { exit(0) }
        
        // Part One
        let totalCaloriesOfEachElf = getTotalCaloriesOfEachElf(string)
        print("The elf with the most calories has \(totalCaloriesOfEachElf.max() ?? 0) calories.")
        
        // Part Two
        var max1 = 0
        var max2 = 0
        var max3 = 0
        for calories in totalCaloriesOfEachElf {
            if calories > max1 {
                max1 = calories
            } else if calories > max2 {
                max2 = calories
            } else if calories > max3 {
                max3 = calories
            }
        }
        let totalCaloriesOfThreeElvesWithMostCalories = max1 + max2 + max3
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
