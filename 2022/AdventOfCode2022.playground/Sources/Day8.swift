import Foundation

public class Day8: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let lines = string.components(separatedBy: "\n")
        let size = lines.count
        var dictionary: [String: Bool] = [:]
        // check visible from left
        for (i, line) in lines.enumerated() {
            var max: Int = -1
            for (j, char) in line.enumerated() {
                guard let height = Int(String(char)) else { continue }
                if height > max {
                    dictionary["\(i)_\(j)"] = true
                    max = height
                }
            }
        }
        // check visible from right
        for (i, line) in lines.enumerated() {
            var max: Int = -1
            for (j, char) in line.reversed().enumerated() {
                guard let height = Int(String(char)) else { continue }
                if height > max {
                    dictionary["\(i)_\(size-1-j)"] = true
                    max = height
                }
            }
        }
        // check visible from top
        for i in 0...size-1 {
            var max: Int = -1
            for j in 0...size-1 {
                let line = lines[j]
                let chars = line.map { String($0) }
                guard let height = Int(chars[i]) else { continue }
                if height > max {
                    dictionary["\(j)_\(i)"] = true
                    max = height
                }
            }
        }
        // check visible from bottom
        for i in 0...size-1 {
            var max: Int = -1
            for j in 0...size-1 {
                let line = lines[size-1-j]
                let chars = line.map { String($0) }
                guard let height = Int(chars[i]) else { continue }
                if height > max {
                    dictionary["\(size-1-j)_\(i)"] = true
                    max = height
                }
            }
        }
        print(dictionary.values.filter { $0 == true }.count)
        
        var max: Int = 0
        for i in 0...size-1 {
            for j in 0...size-1 {
                if i == 0 || j == 0 || i == size-1 || j == size-1 { continue }
                
                let characters = lines[i].map { String($0) }
                guard let currentHeight = Int(characters[j]) else { continue }
                
                var leftOffset = 1
                while j - leftOffset > 0 {
                    let height = Int(characters[j-leftOffset])!
                    if currentHeight <= height {
                        break
                    } else {
                        leftOffset += 1
                    }
                }
                
                var rightOffset = 1
                while j + rightOffset < size-1 {
                    let height = Int(characters[j+rightOffset])!
                    if currentHeight <= height {
                        break
                    } else {
                        rightOffset += 1
                    }
                }
                
                var topOffset = 1
                while i - topOffset > 0 {
                    let characters = lines[i-topOffset].map { String($0) }
                    let height = Int(characters[j])!
                    if currentHeight <= height {
                        break
                    } else {
                        topOffset += 1
                    }
                }
                
                var bottomOffset = 1
                while i + bottomOffset < size-1 {
                    let characters = lines[i+bottomOffset].map { String($0) }
                    let height = Int(characters[j])!
                    if currentHeight <= height {
                        break
                    } else {
                        bottomOffset += 1
                    }
                }
                
                let score = leftOffset * rightOffset * topOffset * bottomOffset
                if score > max {
                    max = score
                }
            }
        }
        print(max)
    }
}

