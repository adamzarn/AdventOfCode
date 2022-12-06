import Foundation

public class Day6: Day {
    public static func run() {
        let partOne: Bool = false
        let length: Int = partOne ? 4 : 14
        guard let string = getInputString() else { exit(0) }
        let characters = string.map { String($0) }
        for index in 0..<characters.count {
            guard index > length - 1 else { continue }
            if Set(characters[(index-(length-1))...index]).count == length {
                print(index + 1)
                return
            }
        }
    }
}
