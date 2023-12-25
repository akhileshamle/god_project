import Foundation

// returns an image
func downloadImage(named: String) -> String {
    return "image_\(named)"
}

let image = downloadImage(named: "1")
print(image)

// retuns an image - async
func downloadImage_async(named: String) async throws -> String {
    // simulate 3 seconds delay
    try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
    return "\(Date()) image_\(named)"
}

func test2() async {
    do {
        print("\(Date()) \(#function)")
        let image1_async = try await downloadImage_async(named: "2")
        print(image1_async)
    } catch {
        print(error)
    }
}

Task {
    // this will download single image
    await test2()
}

// the below approach will download 3 images
// 1 at a time - synchronously, waiting for the previous one to finish
// `let images` will get executed once all the images (await) finish
// this in total requires 9 seconds
Task {
    do {
        print("\(Date()) multiple download - sync")
        let image3 = try await downloadImage_async(named: "3")
        let image4 = try await downloadImage_async(named: "4")
        let image5 = try await downloadImage_async(named: "5")
        
        let images = [image3, image4, image5]
        print("\(Date()) \(images)")
    } catch {}
}

// the below approach will start downloading all the 3 images at once
// `let images = try await[...` will wait for all the images to download / return
// this in total requires 3 seconds
Task {
    do {
        print("\(Date()) multile download async")
        async let image6 = try downloadImage_async(named: "6")
        async let image7 = try downloadImage_async(named: "7")
        async let image8 = try downloadImage_async(named: "8")
        
        let images = try await [image6, image7, image8]
        print("\(Date()) \(images)")
    } catch {}
}
