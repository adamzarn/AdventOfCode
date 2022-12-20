import Foundation

public struct Point3D: Hashable {
    var x: Double
    var y: Double
    var z: Double
    
    public init(_ x: Double, _ y: Double, _ z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine("\(x)_\(y)_\(z)")
    }
    
    public static func == (lhs: Point3D, rhs: Point3D) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}
