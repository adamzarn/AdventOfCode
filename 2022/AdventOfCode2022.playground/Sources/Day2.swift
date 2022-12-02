import Foundation

public class Day2: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let games = string.components(separatedBy: "\n").dropLast()
        let letterPairs = games.compactMap { game -> (Letter, Letter)? in
            let letters = game.components(separatedBy: " ")
            guard let letter1 = Letter(rawValue: letters[0]) else { return nil }
            guard let letter2 = Letter(rawValue: letters[1]) else { return nil }
            return (letter1, letter2)
        }
        var sum = 0
        // Part 1
        for letterPair in letterPairs {
            let outcome = letterPair.0.outcome(letter2: letterPair.1)
            sum += outcome.points + letterPair.1.points
        }
        print(sum)
        // Part 2
        sum = 0
        for letterPair in letterPairs {
            guard let desiredOutcome = letterPair.1.desiredOutcome else { continue }
            guard let letter = letterPair.0.letter(given: desiredOutcome) else { continue }
            sum += desiredOutcome.points + letter.points
        }
        print(sum)
    }
}

public enum Letter: String {
    case A
    case B
    case C
    case X
    case Y
    case Z
    
    var points: Int {
        switch self {
        case .A, .X: return 1
        case .B, .Y: return 2
        case .C, .Z: return 3
        }
    }
    
    var correspondingLetter: Letter? {
        switch self {
        case .X: return .A
        case .Y: return .B
        case .Z: return .C
        case .A: return .X
        case .B: return .Y
        case .C: return .Z
        }
    }
    
    func outcome(letter2: Letter) -> Outcome {
        guard self != letter2.correspondingLetter else { return .draw }
        if self == .A && letter2 == .Y || self == .B && letter2 == .Z || self == .C && letter2 == .X {
            return .win
        } else {
            return .lose
        }
    }
    
    var desiredOutcome: Outcome? {
        switch self {
        case .X: return .lose
        case .Y: return .draw
        case .Z: return .win
        default: return nil
        }
    }
    
    func letter(given desiredOutcome: Outcome) -> Letter? {
        switch desiredOutcome {
        case .draw: return self.correspondingLetter
        case .win:
            switch self {
            case .A: return .Y
            case .B: return .Z
            case .C: return .X
            default: return nil
            }
        case .lose:
            switch self {
            case .A: return .Z
            case .B: return .X
            case .C: return .Y
            default: return nil
            }
        }
    }
}

public enum Outcome {
    case win
    case draw
    case lose
    
    var points: Int {
        switch self {
        case .win: return 6
        case .draw: return 3
        case .lose: return 0
        }
    }
}
