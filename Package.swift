// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "KMPShared",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "KMPShared",
            targets: ["KMPShared"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "KMPShared",
            path: "./shared/swiftpackage/KMPShared.xcframework"
        ),
    ]
)
