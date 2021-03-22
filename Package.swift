// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "DevstackKmpShared",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "DevstackKmpShared",
            targets: ["DevstackKmpShared"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "DevstackKmpShared",
            path: "./shared/swiftpackage/DevstackKmpShared.xcframework"
        ),
    ]
)
