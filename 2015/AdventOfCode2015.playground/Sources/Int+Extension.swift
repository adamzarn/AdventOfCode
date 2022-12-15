import Foundation

public extension Int {
    var asSingleIntJsonArray: AnyObject {
        try! JSONSerialization.jsonObject(with: "[\(self)]".data(using: .utf8)!) as AnyObject
    }
}
