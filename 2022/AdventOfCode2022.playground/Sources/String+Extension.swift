import Foundation

public extension String {
    static var alphabet: [String] {
        "abcdefghijklmnopqrstuvwxyz".map { String($0) }
    }
    
    var asJson: AnyObject {
        return try! JSONSerialization.jsonObject(with: data(using: .utf8)!) as AnyObject
    }
}

public extension Array where Element == String {
    var grid: [[String]] {
        map { $0.map { String($0)} }
    }
}
