import Foundation

public class Day11: Day {
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let monkeyStrings = string.components(separatedBy: "\n\n")
        var monkeys: [Monkey] = []
        for monkeyString in monkeyStrings {
            let lines = monkeyString.components(separatedBy: "\n")
            let items = lines[1].components(separatedBy: ":").last!.trimmingCharacters(in: .whitespaces).components(separatedBy: ", ").map { Int($0)! }
            let operationLine = lines[2].components(separatedBy: "new = old").last!.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
            let operation = operationLine.first!
            let operationValue = operationLine.last!
            let testValue = Int(lines[3].components(separatedBy: "Test: divisible by ").last!)!
            let trueMonkey = Int(lines[4].components(separatedBy: "monkey ").last!)!
            let falseMonkey = Int(lines[5].components(separatedBy: "monkey ").last!)!
            let monkey = Monkey(items: items,
                                operation: operation,
                                operationValue: operationValue,
                                testValue: testValue,
                                trueMonkey: trueMonkey,
                                falseMonkey: falseMonkey)
            monkeys.append(monkey)
        }
        var mod = 1
        for monkey in monkeys {
            mod *= monkey.testValue
        }
        for _ in 1...10000 {
            for monkey in monkeys {
                while !monkey.items.isEmpty {
                    var item = monkey.items[0]
                    item %= mod
                    monkey.inspectedItems += 1
                    var operationValue = item
                    if let value = Int(monkey.operationValue) {
                        operationValue = value
                    }
                    var newValue: Int
                    if monkey.operation == "+" {
                        newValue = item + operationValue
                    } else if monkey.operation == "-" {
                        newValue = item - operationValue
                    } else if monkey.operation == "*" {
                        newValue = item * operationValue
                    } else if monkey.operation == "/" {
                        newValue = item / operationValue
                    } else {
                        newValue = item
                    }
                    var destinationMonkey: Monkey
                    if newValue % monkey.testValue == 0 {
                        destinationMonkey = monkeys[monkey.trueMonkey]
                    } else {
                        destinationMonkey = monkeys[monkey.falseMonkey]
                    }
                    destinationMonkey.items.append(newValue)
                    monkey.items.removeFirst()
                }
            }
        }
        let sortedInspectionCounts = monkeys.map { $0.inspectedItems }.sorted(by: { $0 > $1 })
        print(sortedInspectionCounts[0]*sortedInspectionCounts[1])
    }
}   

class Monkey {
    var items: [Int]
    var operation: String
    var operationValue: String
    var testValue: Int
    var trueMonkey: Int
    var falseMonkey: Int
    var inspectedItems: Int = 0
    
    init(items: [Int], operation: String, operationValue: String, testValue: Int, trueMonkey: Int, falseMonkey: Int) {
        self.items = items
        self.operation = operation
        self.operationValue = operationValue
        self.testValue = testValue
        self.trueMonkey = trueMonkey
        self.falseMonkey = falseMonkey
    }
}
