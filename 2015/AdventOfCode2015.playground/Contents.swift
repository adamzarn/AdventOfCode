import Foundation

printTimeElapsedWhenRunningCode(title: "Day3") {
    Day3.run()
}

func printTimeElapsedWhenRunningCode(title: String, operation: () -> Void) {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Time elapsed for \(title): \(timeElapsed) s.")
}
