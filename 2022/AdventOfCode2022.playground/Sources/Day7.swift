import Foundation

public class Day7: Day {
    static var currentPath: [String] = []
    static var listingContents: Bool = false
    
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let lines = string.components(separatedBy: "\n").dropLast()
        
        var dictionary: [String: Int] = [:]
        // Create Dictionary
        for line in lines {
            setState(line: line)
            if listingContents {
                dictionary[currentPath.joined(separator: "/")] = 0
            }
        }
        // Add Sizes
        for line in lines {
            setState(line: line)
            if listingContents {
                let components = line.components(separatedBy: " ")
                guard let size = Int(components[0]) else { continue }
                let directory = currentPath.joined(separator: "/")
                for (key, _) in dictionary where directory.contains(key) {
                    dictionary[key] = (dictionary[key] ?? 0) + size
                }
            }
        }

        // Part One
        var sumOfDirectorySizesAtMost100000 = 0
        for (_, value) in dictionary {
            if value <= 100000 {
                sumOfDirectorySizesAtMost100000 += value
            }
        }
        print(sumOfDirectorySizesAtMost100000)

        // Part Two
        let usedSpace = dictionary["root"] ?? 0
        let unusedSpace = 70000000 - usedSpace
        let sizeNeededForUpdate = 30000000 - unusedSpace
        
        var sizeOfDirectoryToDelete = 30000000
        for (_, value) in dictionary where value >= sizeNeededForUpdate && value < sizeOfDirectoryToDelete {
            sizeOfDirectoryToDelete = value
        }
        print(sizeOfDirectoryToDelete)
    }
    
    public static func setState(line: String) {
        if line.hasPrefix("$ cd") {
            listingContents = false
            let directory = line.components(separatedBy: " ").last!
            if directory == ".." {
                currentPath = currentPath.dropLast()
            } else if directory == "/" {
                currentPath = ["root"]
            } else {
                currentPath.append(directory)
            }
        } else if line.hasPrefix("$ ls") {
            listingContents = true
        }
    }
}
