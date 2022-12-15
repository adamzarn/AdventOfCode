import Foundation

public class Day15: Day {
    static var positions: [Pair: Pair] = [:]
    static var noBeaconPoints = Set<Pair>()
    static var row = 2000000
    static var range = 4000000
    
    public static func run() {
        guard let string = getInputString() else { exit(0) }
        let lines = string.components(separatedBy: "\n")
        for line in lines {
            let parts = line.components(separatedBy: "at ").map { $0.replacingOccurrences(of: ": closest beacon is ", with: "")}
            let sensorXY = parts[1].components(separatedBy: ", ").map { $0.components(separatedBy: "=")[1] }
            let sensorPosition = Pair(Int(sensorXY[0])!, Int(sensorXY[1])!)
            let beaconXY = parts[2].components(separatedBy: ", ").map { $0.components(separatedBy: "=")[1] }
            let beaconPosition =  Pair(Int(beaconXY[0])!, Int(beaconXY[1])!)
            positions[sensorPosition] = beaconPosition
        }
        
        // Part One
        for (sensor, beacon) in positions {
            let distance = distanceBetween(sensor, beacon)
            for x in sensor.x-distance...sensor.x+distance {
                let pair = Pair(x, row)
                if distanceBetween(pair, sensor) <= distance && pair != beacon {
                    noBeaconPoints.insert(pair)
                }
            }
        }
        print(noBeaconPoints.filter { $0.y == row }.count)

        // Part Two
        var newBeacon: Pair?
        for (sensor, beacon) in positions {
            if newBeacon != nil {
                break
            }
            let distance = distanceBetween(sensor, beacon)
            let offset = distance + 1
            for i in 0...offset {
                let pair1 = Pair(sensor.x - offset + i, sensor.y - i)
                let pair2 = Pair(sensor.x + i, sensor.y + offset - i)
                let pair3 = Pair(sensor.x + offset - i, sensor.y + i)
                let pair4 = Pair(sensor.x - i, sensor.y - offset - i)
                if pointCouldBeBeacon(pair: pair1) {
                    newBeacon = pair1
                    break
                }
                if pointCouldBeBeacon(pair: pair2) {
                    newBeacon = pair2
                    break
                }
                if pointCouldBeBeacon(pair: pair3) {
                    newBeacon = pair3
                    break
                }
                if pointCouldBeBeacon(pair: pair4) {
                    newBeacon = pair4
                    break
                }
            }
        }
        if let newBeacon = newBeacon {
            print(newBeacon.x * range + newBeacon.y)
        }
    }
    
    static func pointCouldBeBeacon(pair: Pair) -> Bool {
        let min = 0
        let max = range
        guard pair.x >= min && pair.x <= max && pair.y >= min && pair.y <= max else { return false }
        var value: Bool = true
        for (sensor, beacon) in positions {
            let distance = distanceBetween(sensor, beacon)
            if distanceBetween(pair, sensor) <= distance {
                value = false
            }
        }
        return value
    }
    
    static func distanceBetween(_ pair1: Pair, _ pair2: Pair) -> Int {
        return abs(pair1.x - pair2.x) + abs(pair1.y - pair2.y)
    }
}
