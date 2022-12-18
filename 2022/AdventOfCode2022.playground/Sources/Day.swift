import Foundation

public class Day {
    public var input: String = ""
    public var lines: [String] = []
    public init() {
        let resource = String(describing: self).split(".")[1]
        guard let url = Bundle.main.url(forResource: resource, withExtension: "txt") else { fatalError() }
        guard let data = try? Data(contentsOf: url) else { fatalError() }
        self.input = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        self.lines = self.input.components(separatedBy: "\n")
    }
    
    public static func getInputString() -> String? {
        guard let url = Bundle.main.url(forResource: String(describing: self), withExtension: "txt") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
