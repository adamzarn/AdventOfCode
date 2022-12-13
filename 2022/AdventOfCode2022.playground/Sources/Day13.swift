import Foundation

public class Day13: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        
        // Part One
        let pairs: [String] = string.components(separatedBy: "\n\n")
        var sum: Int = 0
        for (index, pair) in pairs.enumerated() {
            let components = pair.components(separatedBy: "\n")
            if compare(x: components[0].asJson, y: components[1].asJson) <= 0 {
                sum += index + 1
            }
        }
        print(sum)
        
        // Part Two
        var lines = string.replacingOccurrences(of: "\n\n", with: "\n").dropLast().components(separatedBy: "\n")
        lines.append(contentsOf: ["[[2]]", "[[6]]"])
        let sortedLines = lines.sorted(by: { line1, line2 in
            return compare(x: line1.asJson, y: line2.asJson) < 0
        })
        print((sortedLines.firstIndex(of: "[[2]]")! + 1) * (sortedLines.firstIndex(of: "[[6]]")! + 1))
    }
    
    public static func compare(x: AnyObject, y: AnyObject) -> Int {
        if let xInt = x as? Int {
            if let yInt = y as? Int {
                return xInt - yInt
            } else {
                return compare(x: xInt.asSingleIntJsonArray, y: y)
            }
        } else {
            if let yInt = y as? Int {
                return compare(x: x, y: yInt.asSingleIntJsonArray)
            }
        }
        if let a = x as? [AnyObject], let b = y as? [AnyObject] {
            for (c, d) in zip(a, b) {
                let value = compare(x: c, y: d)
                guard value == 0 else { return value }
            }
            return a.count - b.count
        }
        return -1
    }
}
