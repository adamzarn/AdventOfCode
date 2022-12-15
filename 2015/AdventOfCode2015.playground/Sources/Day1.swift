import Foundation

public class Day1: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        var floor = 0
        for (index, c) in string.enumerated() {
            floor += c == "(" ? 1 : -1
            if floor == -1 {
                print(index + 1)
            }
        }
        print(floor)
    }
}
