import Foundation

public struct Pair: Hashable {
    var x: Int
    var y: Int
    
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    public func hash(into hasher: inout Hasher) {
        let cantorValue = ((x + y) * (x + y) + x + 3 * y) / 2
        hasher.combine(Int(cantorValue))
    }
    
    public static func == (lhs: Pair, rhs: Pair) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
