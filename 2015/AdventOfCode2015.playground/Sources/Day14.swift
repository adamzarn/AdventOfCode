import Foundation

public class Day14: Day {
    static var minX: Int = 500
    static var maxX: Int = 500
    static var maxY: Int = 0
    static var grid: [Pair: Int] = [:]
    static var sandCount = 0
    static var currentPosition = Pair(500, 0)

    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let lines = string.components(separatedBy: "\n")
        for line in lines {
            let positions = line.components(separatedBy: " -> ")
                .map { $0.components(separatedBy: ",") }
                .map { Pair(Int($0[0])!, Int($0[1])!) }
            for (index, position) in positions.enumerated() {
                if position.y > maxY {
                    maxY = position.y
                }
                if index > 0 {
                    let previous = positions[index-1]
                    let xValues = [previous.x, position.x]
                    for value in xValues.min()!...xValues.max()! {
                        grid[Pair(value, position.y)] = 0
                    }
                    let yValues = [previous.y, position.y]
                    for value in yValues.min()!...yValues.max()! {
                        grid[Pair(position.x, value)] = 0
                    }
                }
            }
        }
        maxY += 2
        while grid[Pair(499,1)] == nil || grid[Pair(500,1)] == nil || grid[Pair(501,1)] == nil {
            let downPair = Pair(currentPosition.x, currentPosition.y + 1)
            let downLeftPair = Pair(currentPosition.x - 1, currentPosition.y + 1)
            let downRightPair = Pair(currentPosition.x + 1, currentPosition.y + 1)
            if currentPosition.y + 1 == maxY {
                settle(at: currentPosition)
            } else if grid[downPair] == nil {
                currentPosition = downPair
            } else if grid[downLeftPair] == nil {
                currentPosition = downLeftPair
            } else if grid[downRightPair] == nil {
                currentPosition = downRightPair
            } else {
                settle(at: currentPosition)
            }
        }
        grid[currentPosition] = 1
        printGrid()
        print(sandCount + 1)
    }
    
    static func printGrid() {
        for y in 0...maxY {
            var string = ""
            for x in minX...maxX {
                if y == maxY {
                    string += "#"
                } else {
                    string += grid[Pair(x,y)] == nil ? "." : grid[Pair(x,y)] == 0 ? "#" : "o"
                }
            }
            print(string)
        }
    }
    
    static func settle(at position: Pair) {
        grid[position] = 1
        if position.x < minX {
            minX = position.x
        }
        if position.x > maxX {
            maxX = position.x
        }
        sandCount += 1
        currentPosition = Pair(500, 0)
    }
}
