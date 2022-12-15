import Foundation

public class Day9: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let lines = string.components(separatedBy: "\n")
        let partOne: Bool = true
        var headPosition: (Int, Int) = (0, 0)
        var tailPositions: [(Int, Int)] = Array(repeating: (0,0), count: partOne ? 1 : 9)
        var tailPositionStrings: [String] = ["0_0"]
        for line in lines {
            let components = line.components(separatedBy: " ")
            let direction = components[0]
            let steps = Int(components[1])!
            for _ in 0..<steps {
                switch direction {
                case "L": headPosition.0 -= 1
                case "R": headPosition.0 += 1
                case "D": headPosition.1 -= 1
                case "U": headPosition.1 += 1
                default: continue
                }
                for index in 0..<tailPositions.count {
                    if index == 0 {
                        tailPositions[0] = getNewTailPosition(currentHeadPosition: headPosition,
                                                              currentTailPosition: tailPositions[0])
                    } else {
                        tailPositions[index] = getNewTailPosition(currentHeadPosition: tailPositions[index-1],
                                                                  currentTailPosition: tailPositions[index])
                    }
                }
                tailPositionStrings.append("\(tailPositions.last!.0)_\(tailPositions.last!.1)")
            }
        }
        print(Set(tailPositionStrings).count)
    }
    
    static func getNewTailPosition(currentHeadPosition: (Int, Int),
                                   currentTailPosition: (Int, Int)) -> (Int, Int) {
        var newTailPosition = currentTailPosition
        if abs(currentTailPosition.0 - currentHeadPosition.0) <= 1 && abs(currentTailPosition.1 - currentHeadPosition.1) <= 1 {
            return newTailPosition
        } else if abs(currentHeadPosition.0 - currentTailPosition.0) >= 1 && abs(currentHeadPosition.1 - currentTailPosition.1) >= 1 {
            newTailPosition.0 += currentHeadPosition.0 > currentTailPosition.0 ? 1 : -1
            newTailPosition.1 += currentHeadPosition.1 > currentTailPosition.1 ? 1 : -1
        } else if abs(currentHeadPosition.0 - currentTailPosition.0) >= 1 {
            newTailPosition.0 += currentHeadPosition.0 > currentTailPosition.0 ? 1 : -1
        } else if abs(currentHeadPosition.1 - currentTailPosition.1) >= 1 {
            newTailPosition.1 += currentHeadPosition.1 > currentTailPosition.1 ? 1 : -1
        }
        return newTailPosition
    }
}
