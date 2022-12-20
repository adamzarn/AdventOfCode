import Foundation

public class Day18: Day {
    var faces: [Point3D: Int] = [:]
    let offsets: [(Double, Double, Double)] = [(0, 0, 0.5), (0, 0.5, 0), (0.5, 0, 0), (0, 0, -0.5), (0, -0.5, 0), (-0.5, 0, 0)]
    
    var maxX = -Double.greatestFiniteMagnitude
    var maxY = -Double.greatestFiniteMagnitude
    var maxZ = -Double.greatestFiniteMagnitude
    
    var minX = Double.greatestFiniteMagnitude
    var minY = Double.greatestFiniteMagnitude
    var minZ = Double.greatestFiniteMagnitude
    
    var droplet = Set<Point3D>()
    
    public func run() {
        let points: [(Double, Double, Double)] = input.split("\n").map { line in
            let numbers = line.split(",")
            return (Double(numbers[0])!, Double(numbers[1])!, Double(numbers[2])!)
        }
        for (x, y, z) in points {
            droplet.insert(Point3D(x, y, z))
            
            maxX = [maxX, x].max()!
            maxY = [maxY, y].max()!
            maxZ = [maxZ, z].max()!

            minX = [minX, x].min()!
            minY = [minY, y].min()!
            minZ = [minZ, z].min()!

            for (dx, dy, dz) in offsets {
                let face = Point3D(x + dx, y + dy, z + dz)
                if faces[face] == nil {
                    faces[face] = 0
                }
                faces[face] = (faces[face] ?? 0) + 1
            }
        }
        print(faces.values.filter { $0 == 1 }.count)
        
        maxX += 1
        maxY += 1
        maxZ += 1
        
        minX -= 1
        minY -= 1
        minZ -= 1
        
        var queue = [Point3D(minX, minY, minZ)]
        var exteriorAir = Set(arrayLiteral: Point3D(minX, minY, minZ))
        
        while !queue.isEmpty {
            let point = queue.first!
            queue.removeFirst()
            
            for (dx, dy, dz) in offsets {
                let neighbor = Point3D(point.x + (dx * 2), point.y + (dy * 2), point.z + (dz * 2))
                let inBounds = minX <= neighbor.x && neighbor.x <= maxX &&
                minY <= neighbor.y && neighbor.y <= maxY &&
                minZ <= neighbor.z && neighbor.z <= maxZ
                
                if !inBounds {
                    continue
                }
                
                if droplet.contains(neighbor) || exteriorAir.contains(neighbor) {
                    continue
                }
                
                exteriorAir.insert(neighbor)
                queue.append(neighbor)
            }
        }
                
        var exteriorFaces = Set<Point3D>()
        
        for point in exteriorAir {
            for (dx, dy, dz) in offsets {
                let face = Point3D(point.x + dx, point.y + dy, point.z + dz)
                exteriorFaces.insert(face)
            }
        }
        
        var total = 0
        
        for (face, _) in faces {
            if exteriorFaces.contains(face) {
                total += 1
            }
        }
        
        print(total)
    }
}
