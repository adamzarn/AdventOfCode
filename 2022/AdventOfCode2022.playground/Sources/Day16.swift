import Foundation

public class Day16: Day {
    var flowRates: [String: Int] = [:]
    var tunnels: [String: [String]] = [:]
    var distances: [String: [String: Int]] = [:]
    var cache: [String: Int] = [:]

    public func run() {
        var valveComponents: [[String]] = []
        
        for line in lines {
            let components = line.split(["Valve "," has flow rate=","; tunnels lead to valves ", "; tunnel leads to valve "]).filter { !$0.isEmpty }
            valveComponents.append(components)
        }
        for components in valveComponents {
            let name = components[0]
            flowRates[name] = Int(components[1])!
            tunnels[name] = components[2].split(", ")
        }
        
        // Part One
        for (valve, flowRate) in flowRates {
            if valve != "AA" && flowRate == 0 {
                continue
            }
            if valve == "AA" {
                distances[valve] = ["AA": 0]
            } else {
                distances[valve] = [valve: 0, "AA": 0]
            }
            var visited: Set<String> = Set([valve])
            var queue: [(Int, String)] = [(0, valve)]
            while !queue.isEmpty {
                let (distance, currentValve) = queue.first!
                queue.removeFirst()
                for connectedValve in tunnels[currentValve]! {
                    if visited.contains(connectedValve) {
                        continue
                    }
                    visited.insert(connectedValve)
                    if flowRates[connectedValve] != 0 {
                        distances[valve]?[connectedValve] = distance + 1
                    }
                    queue.append((distance + 1, connectedValve))
                }
            }
            
            distances[valve]![valve] = nil
            if valve != "AA" {
                distances[valve]!["AA"] = nil
            }
        }
        
        // print(getMaxValue(30, "AA", ""))

        // Part Two
        let nonEmptyValves = flowRates.filter { $0.1 != 0 }.map { $0.0 }.sorted()
        var max = 0
        let product = product([true, false], repeated: nonEmptyValves.count)
        for array in product {
            var openedValves1 = ""
            var openedValves2 = ""
            for (index, value) in array.enumerated() {
                if value {
                    openedValves1 += nonEmptyValves[index]
                } else {
                    openedValves2 += nonEmptyValves[index]
                }
            }
            max = [max, getMaxValue(26, "AA", openedValves1) + getMaxValue(26, "AA", openedValves2)].max()!
        }
        print(max)
    }
    
    func getMaxValue(_ time: Int, _ valve: String, _ openedValves: String) -> Int {
        if let value = cache["\(time)_\(valve)_\(openedValves)"] {
            return value
        }
        var maxValue = 0
        for (connectedValve, distance) in distances[valve]! as [String: Int] {
            let remainingTime = time - (distance + 1)
            if openedValves.contains(connectedValve) {
                continue
            }
            if remainingTime <= 0 {
                continue
            }
            let newOpenedValves = (openedValves.split(" ") + [connectedValve]).sorted().joined(separator: " ")
            maxValue = [maxValue, getMaxValue(remainingTime, connectedValve, newOpenedValves) + (flowRates[connectedValve]! * remainingTime)].max()!
        }
        cache["\(time)_\(valve)_\(openedValves)"] = maxValue
        return maxValue
    }
}
