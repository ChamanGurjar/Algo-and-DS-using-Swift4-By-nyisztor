import QuartzCore

public class BenchTimer {
    
    public static func measureBlock(closure: () -> Void) -> CFTimeInterval {
        let runCount = 10
        var executionTimes = Array<Double>(repeating: 0.0, count: runCount)
        for i in 0..<runCount {
            let startTime = CACurrentMediaTime()
            // print("StartTime -> \(startTime)")
            closure()
            let endTime = CACurrentMediaTime()
            //print("Endtime -> \(endTime)")
            let exectTime = endTime-startTime
            executionTimes[i] = exectTime
        }
        
        return (executionTimes.reduce(0, +)) / Double(runCount)
    }
}

public extension CFTimeInterval {
    public var formattedTime: String {
        return self >= 1000 ? String(Int(self)) + "s"
            : self >= 1 ? String(format: "%.3gs", self)
            : self >= 1e-3 ? String(format: "%.3gms", self * 1e3)
            : self >= 1e-6 ? String(format: "%.3gµs", self * 1e6)
            : self < 1e-9 ? "0s"
            : String(format: "%.3gns", self*1e9)
    }
}

func startsWithZero(array: [Int]) -> Bool {
    guard array.count != 0 else {
        return false
    }
    return array.first == 0 ? true : false
}


var smallArray = [1,0,0]
var exectTime =  BenchTimer.measureBlock {
    _ = startsWithZero(array: smallArray)
}
print("Avg startsWithZero exec time for array with \(smallArray.count) elements: \(exectTime.formattedTime)")


var mediumArray = Array<Int>(repeating: 0, count: 10000)
var exectTimeForMediumArray =  BenchTimer.measureBlock {
    _ = startsWithZero(array: mediumArray)
}
print("Avg startsWithZero exec time for array with \(mediumArray.count) elements: \(exectTimeForMediumArray.formattedTime)")

var largeArray = Array<Int>(repeating: 0, count: 10000000)
var exectTimeForLargeArray =  BenchTimer.measureBlock {
    _ = startsWithZero(array: largeArray)
}
print("Avg startsWithZero exec time for array with \(largeArray.count) elements: \(exectTimeForLargeArray.formattedTime)")

print("\n")

/** Dictionary Implementation */
let smallDictionary = ["one": 1, "two": 2, "three": 3]
exectTime = BenchTimer.measureBlock {
    _ = smallDictionary["two"]
}
print("Average lookup time in a dictionary with \(smallDictionary.count) elements: \(exectTime.formattedTime)")

// Generates dictionaries of given size
func generateDict(size: Int) -> Dictionary<String, Int> {
    var result = Dictionary<String, Int>()
    guard size > 0 else {
        return result
    }
    
    for i in 0..<size {
        let key = String(i)
        result[key] = i
    }
    return result
}

let mediumDict = generateDict(size: 500)
exectTime = BenchTimer.measureBlock {
    _ = mediumDict["324"]
}
print("Average lookup time in a dictionary with \(mediumDict.count) elements: \(exectTime.formattedTime)")

let hugeDict = generateDict(size: 100000)
exectTime = BenchTimer.measureBlock {
    _ = hugeDict["55555"]
}
print("Average lookup time in a dictionary with \(hugeDict.count) elements: \(exectTime.formattedTime)")
