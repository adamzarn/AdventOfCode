import Foundation

public extension String {
    static var alphabet: [String] {
        "abcdefghijklmnopqrstuvwxyz".map { String($0) }
    }
}

public extension Array where Element == String {
    var grid: [[String]] {
        map { $0.map { String($0)} }
    }
}
