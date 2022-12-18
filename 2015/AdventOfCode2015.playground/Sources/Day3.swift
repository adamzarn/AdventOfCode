import Foundation

public class Day3: Day {
    static var santaHouses = Set<Pair>([Pair(0,0)])
    static var roboHouses = Set<Pair>([Pair(0,0)])
    static var santaHouse = Pair(0,0)
    static var roboHouse = Pair(0,0)

    public static func run() {
        guard let string = getInputString() else { exit(0) }
        var robo = false
        for c in string {
            if robo {
                if c == "^" {
                    roboHouse = Pair(roboHouse.x, roboHouse.y+1)
                } else if c == ">" {
                    roboHouse = Pair(roboHouse.x+1, roboHouse.y)
                } else if c == "v" {
                    roboHouse = Pair(roboHouse.x, roboHouse.y-1)
                } else if c == "<" {
                    roboHouse = Pair(roboHouse.x-1, roboHouse.y)
                }
                roboHouses.insert(roboHouse)
            } else {
                if c == "^" {
                    santaHouse = Pair(santaHouse.x, santaHouse.y+1)
                } else if c == ">" {
                    santaHouse = Pair(santaHouse.x+1, santaHouse.y)
                } else if c == "v" {
                    santaHouse = Pair(santaHouse.x, santaHouse.y-1)
                } else if c == "<" {
                    santaHouse = Pair(santaHouse.x-1, santaHouse.y)
                }
                santaHouses.insert(santaHouse)
            }
            robo.toggle()
        }
        print(roboHouses.union(santaHouses).count)
    }
}
