// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Navigating",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "Navigating",
            targets: ["Navigating"]
        ),
    ],
    targets: [
        .target(
            name: "Navigating"
        ),
        .testTarget(
            name: "NavigatingTests",
            dependencies: ["Navigating"]
        ),
    ]
)
