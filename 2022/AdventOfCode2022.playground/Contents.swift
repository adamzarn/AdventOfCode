import Foundation

printTimeElapsedWhenRunningCode(title: "Day6") {
    Day6.run()
}

func printTimeElapsedWhenRunningCode(title: String, operation: ()->()) {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Time elapsed for \(title): \(timeElapsed) s.")
}
