import Foundation

public class Day12: Day {
    static var startingRow: Int = 0
    static var startingColumn: Int = 0
    static var endingRow: Int = 0
    static var endingColumn: Int = 0
    
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let lines: [String] = string.components(separatedBy: "\n")
        var partOne: Bool = true
        var grid: [Int: [Int: Int]] = [:]
        var startingPositions: [(Int, Int)] = []
        for (i, line) in lines.enumerated() {
            for (j, letter) in line.enumerated() {
                if grid[i] == nil {
                    grid[i] = [:]
                }
                if !partOne {
                    if letter == "a" {
                        startingPositions.append((i,j))
                    }
                }
                if letter == "S" {
                    startingRow = i
                    startingColumn = j
                    grid[i]?[j] = 0
                    startingPositions.append((i,j))
                }
                if letter == "E" {
                    endingRow = i
                    endingColumn = j
                    grid[i]?[j] = 25
                } else {
                    grid[i]?[j] = String.alphabet.firstIndex(of: String(letter)) ?? 0
                }
            }
        }
        
        var distances: [Int] = []
        
        for (sr, sc) in startingPositions {
            var queue: [(Int, Int, Int)] = [(0, sr, sc)]
            var visited: Set<Pair> = Set([Pair(sc, sr)])
            while !queue.isEmpty {
                guard let (d, r, c) = queue.first else { continue }
                queue.removeFirst()
                for (nextRow, nextColumn) in [(r+1,c), (r-1,c), (r,c+1), (r,c-1)] {
                    if nextRow < 0 || nextColumn < 0 || nextRow >= grid.count || nextColumn >= grid[0]!.count {
                        continue
                    }
                    if visited.contains(Pair(nextRow, nextColumn)) {
                        continue
                    }
                    if (grid[nextRow]?[nextColumn] ?? 0) - (grid[r]?[c] ?? 0) > 1 {
                        continue
                    }
                    if nextRow == endingRow && nextColumn == endingColumn {
                        distances.append(d+1)
                        break
                    }
                    visited.insert(Pair(nextRow, nextColumn))
                    queue.append((d+1, nextRow, nextColumn))
                }
            }
        }
        print(distances.min())
    }
}


