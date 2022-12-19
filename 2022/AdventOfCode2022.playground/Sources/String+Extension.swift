import Foundation

public extension String {
    var asArray: [String] {
        return map { String($0) }
    }
    
    static var alphabet: [String] {
        "abcdefghijklmnopqrstuvwxyz".map { String($0) }
    }
    
    var asJson: AnyObject {
        return try! JSONSerialization.jsonObject(with: data(using: .utf8)!) as AnyObject
    }
    
    func split(_ separator: String) -> [String] {
        return components(separatedBy: separator)
    }
    
    func split(_ separators: [String]) -> [String] {
        var output: [String] = [self]
        for separator in separators {
            output = output.flatMap { $0.split(separator) }
        }
        return output.map { $0.trimmingCharacters(in: .whitespaces)}
    }
}

public extension Array where Element == String {
    var grid: [[String]] {
        map { $0.map { String($0)} }
    }
}
