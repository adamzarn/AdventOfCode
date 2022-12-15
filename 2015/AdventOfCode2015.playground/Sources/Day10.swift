import Foundation

public class Day10: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let lines = string.components(separatedBy: "\n")
        var queue: [(Int, Int)] = []
        for line in lines {
            let components = line.components(separatedBy: " ")
            var number: Int = 0
            var executionSteps: Int = 1
            if components.count == 2 {
                number = Int(components[1])!
                executionSteps = 2
            }
            queue.append((number, executionSteps))
        }
        var cycle = 0
        var x = 1
        var sum = 0
        var crtLines: [String] = []
        while !queue.isEmpty {
            if crtLines.isEmpty || crtLines[crtLines.count-1].count == 40 {
                crtLines.append("")
            }
            let verticalPosition = 40*(crtLines.count-1)
            let lit = Array((x-1 + verticalPosition)...(x+1 + verticalPosition)).contains(cycle)
            if crtLines[crtLines.count-1].count == 40 {
                crtLines.append(lit ? "#" : ".")
            } else {
                crtLines[crtLines.count-1].append(lit ? "█" : " ")
            }
            cycle += 1
            if [20, 60, 100, 140, 180, 220].contains(cycle) {
                sum += cycle*x
            }
            queue[0].1 -= 1
            if queue[0].1 == 0 {
                x += queue[0].0
                queue.remove(at: 0)
            }
        }
        print(sum)
        for crtLine in crtLines {
            print(crtLine)
        }
    }
}
