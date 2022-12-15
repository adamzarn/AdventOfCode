import Foundation

public class Day2: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let presents = string.components(separatedBy: "\n").map { $0.components(separatedBy: "x").map { Int($0)! }}
        var sum = 0
        for present in presents {
            let l = present[0]
            let w = present[1]
            let h = present[2]
            let sideAreas = [l*w, w*h, l*h]
            let slack = sideAreas.min()!
            sum += 2*sideAreas.reduce(0, +) + slack
        }
        print(sum)
        var feet = 0
        for present in presents {
            let l = present[0]
            let w = present[1]
            let h = present[2]
            let sides = [l,w,h].sorted()
            feet += 2*sides[0] + 2*sides[1] + l*w*h
        }
        print(feet)
    }
}
