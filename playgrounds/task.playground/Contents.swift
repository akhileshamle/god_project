import Foundation

func main() async throws {
    print("hello world")
    
    Task {
        print("hello task 1 world")
        print("hello task 1 world 2")
        print("hello task 1 world 3")
        print("hello task 1 world 4")
    }
    
    Task {
        print("hello task 2 workd")
        print("hello task 2 workd 2")
        print("hello task 2 workd 3")
    }
    
    Task {
        print("hello task 3 workd")
        print("hello task 3 workd 2")
    }
    
    try await Task.sleep(for: .seconds(1))
    print("waking up...")
    
    await withTaskGroup(of: Data.self) { group in
        
    }
}

Task {
    try await main()
}
