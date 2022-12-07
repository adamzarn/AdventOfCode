import Foundation

public class Day6: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let partOne: Bool = true
        let length: Int = partOne ? 4 : 14
        let characters = string.map { String($0) }
        for index in (length-1)..<characters.count {
            if Set(characters[(index-(length-1))...index]).count == length {
                print(index + 1)
                return
            }
        }
    }
}
