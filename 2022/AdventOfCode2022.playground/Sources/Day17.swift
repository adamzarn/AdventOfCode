import Foundation

public class Day17: Day {
    var takenPositions: [Int: [Int: Bool]] = [:]
    
    var rocks: [Int: Set<Pair>] = [
        0: Set(arrayLiteral: Pair(3, 1), Pair(4, 1), Pair(5, 1), Pair(6, 1)),
        1: Set(arrayLiteral: Pair(4, 1), Pair(3, 2), Pair(4, 2), Pair(5, 2), Pair(4, 3)),
        2: Set(arrayLiteral: Pair(3, 1), Pair(4, 1), Pair(5, 1), Pair(5, 2), Pair(5, 3)),
        3: Set(arrayLiteral: Pair(3, 1), Pair(3, 2), Pair(3, 3), Pair(3, 4)),
        4: Set(arrayLiteral: Pair(3, 1), Pair(4, 1), Pair(3, 2), Pair(4, 2))
    ]
    
    var height: Int = 0
    var rockCount: Int = 0
    var fallingRockPosition: Set<Pair>!
    var seen: [String: (Int, Int)] = [:]
    var jump: Int = 0
    var windIndex = 0
    
    let oneTrillion = 1_000_000_000_000
    
    public func run() {
        let windGusts = input.asArray
        fallingRockPosition = addNewRock(rocks[0]!)
        while rockCount < oneTrillion {
            let windGust = windGusts[windIndex % windGusts.count]
            let xOffset = windGust == ">" ? 1 : -1
            if canMoveHorizontally(fallingRockPosition, x: xOffset) {
                fallingRockPosition = moveHorizontally(fallingRockPosition, x: xOffset)
            }
            if canMoveDown(fallingRockPosition) {
                fallingRockPosition = moveDown(fallingRockPosition)
            } else {
                for pair in fallingRockPosition {
                    if pair.y > height {
                        height = pair.y
                    }
                }
                for pair in fallingRockPosition {
                    if takenPositions[pair.y] == nil {
                        takenPositions[pair.y] = [:]
                        takenPositions[pair.y]![pair.x] = true
                    } else {
                        takenPositions[pair.y]![pair.x] = true
                    }
                }
                rockCount += 1
                if rockCount > oneTrillion {
                    break
                }
                fallingRockPosition = addNewRock(rocks[rockCount % 5]!)
                let key = "\(windIndex % windGusts.count)_\(rockCount % 5)_\(snapshot(rows: 1))"
                if let (lastRockCount, lastHeight) = seen[key] {
                    let rocksInPattern = rockCount - lastRockCount
                    let heightOfPattern = height - lastHeight
                    let rocksLeft = oneTrillion - rockCount
                    let repititions = rocksLeft / rocksInPattern
                    jump = repititions * heightOfPattern
                    rockCount += repititions * rocksInPattern
                    seen = [:]
                }
                seen[key] = (rockCount, height)
            }
            windIndex += 1
        }
        print(height + jump)
    }
    
    func snapshot(rows: Int) -> String {
        var snapshot = ""
        for i in (height-1-rows)...height-1 {
            if let positions = takenPositions[i] {
                var string = ""
                for j in 1...7 {
                    if positions[j] != nil {
                        string += "#"
                    } else {
                        string += "."
                    }
                }
                snapshot += string
            } else {
                snapshot += "......."
            }
        }
        return snapshot
    }
    
    func addNewRock(_ rock: Set<Pair>) -> Set<Pair> {
        var newSet = Set<Pair>()
        for pair in rock {
            newSet.insert(Pair(pair.x, pair.y + height + 3))
        }
        return newSet
    }
    
    func canMoveHorizontally(_ rock: Set<Pair>, x: Int) -> Bool {
        let proposedPosition = moveHorizontally(fallingRockPosition, x: x)
        for pair in proposedPosition {
            if takenPositions[pair.y]?[pair.x] != nil {
                return false
            }
            if pair.x < 1 || pair.x > 7 {
                return false
            }
        }
        return true
    }
    
    func moveHorizontally(_ rock: Set<Pair>, x: Int) -> Set<Pair> {
        var newSet = Set<Pair>()
        for pair in rock {
            newSet.insert(Pair(pair.x + x, pair.y))
        }
        return newSet
    }
    
    func canMoveDown(_ rock: Set<Pair>) -> Bool {
        let proposedPosition = moveDown(fallingRockPosition)
        for pair in proposedPosition {
            if takenPositions[pair.y]?[pair.x] != nil {
                return false
            }
            if pair.y < 1 {
                return false
            }
        }
        return true
    }
    
    func moveDown(_ rock: Set<Pair>) -> Set<Pair> {
        var newSet = Set<Pair>()
        for pair in rock {
            newSet.insert(Pair(pair.x, pair.y - 1))
        }
        return newSet
    }
}
