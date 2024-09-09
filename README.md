# NetworkLayer

This repository contains the NetworkLayer.

## Write Requests Fast!

NetworkLayer's compact syntax and extensive feature set allow requests with powerful features like automatic retry to be written in just a few lines of code.

```swift
import NetworkLayer

let networkService = URLSessionNetworkService()

// Automatic String to URL conversion, Swift concurrency support, and automatic retry.
Task {
    do {
        let users: [UserModel] = try await networkService.request(endpoint: userEndpoint, responseModel: [UserModel].self)
        print(users)
    } catch {
        print("Failed to fetch users: \(error)")
    }
}
```

# How to Use it?

-  Once you have your Swift package set up, adding `NetworkLayer` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift` or the Package list in Xcode.

```swift
dependencies: [
    .package(url: "https://github.com/obadasemary/NetworkLayer.git", .upToNextMajor(from: "1.0.2"))
]
```
