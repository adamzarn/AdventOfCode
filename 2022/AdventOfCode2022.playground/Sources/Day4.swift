import Foundation

public class Day4: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let lines = string.components(separatedBy: "\n").dropLast()
        var fullyContainedCount = 0
        var overlappingCount = 0
        for line in lines {
            let pairs = line.components(separatedBy: ",")
            let bounds1 = (pairs.first ?? "").components(separatedBy: "-").compactMap { Int($0) }
            let bounds2 = (pairs.last ?? "").components(separatedBy: "-").compactMap { Int($0) }
            if bounds1.first! <= bounds2.first! && bounds1.last! >= bounds2.last! {
                fullyContainedCount += 1
            } else if bounds2.first! <= bounds1.first! && bounds2.last! >= bounds1.last! {
                fullyContainedCount += 1
            }
            if bounds1.first! <= bounds2.first! && bounds1.last! >= bounds2.first! {
                overlappingCount += 1
            } else if bounds2.first! <= bounds1.first! && bounds2.last! >= bounds1.first! {
                overlappingCount += 1
            }
        }
        print(fullyContainedCount)
        print(overlappingCount)
    }
}
