import Foundation

public class Day {
    public static func getInputString() -> String? {
        guard let url = Bundle.main.url(forResource: String(describing: self), withExtension: "txt") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
