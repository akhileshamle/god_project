import Foundation

enum CustomError: Error {
    case sampleError
    case invalidInput
}

var resultSample: Result<String, Error>

// creating a result
resultSample = .success("success")
print(resultSample)

resultSample = .failure(CustomError.sampleError)
print(resultSample)

switch resultSample {
case .success(let sum):
    print(sum)
case .failure(let error):
    print(error)
}

// result in a func
func addNoZerosAllowed(_ a: Int,_ b: Int) -> Result<Int, Error> {
    guard a != 0, b != 0 else {
        return .failure(CustomError.invalidInput)
    }
    return .success(a + b)
}

print(addNoZerosAllowed(1, 2))
print(addNoZerosAllowed(0, 1))

func printResult(result: Result<Int, Error>) {
    switch result {
    case let .success(sum):
        print(sum)
    case let .failure(error):
        print(error)
    }
}

print(printResult(result: addNoZerosAllowed(3, 7)))
print(printResult(result: addNoZerosAllowed(12, 7)))
print(printResult(result: addNoZerosAllowed(12, 0)))

