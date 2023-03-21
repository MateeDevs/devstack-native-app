// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedDomain",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SharedDomain",
            targets: ["SharedDomain"]
        ),
        .library(
            name: "SharedDomainMocks",
            targets: ["SharedDomainMocks"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/hmlongco/Resolver.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/krzysztofzablocki/Sourcery.git", .revision("eb75bb23ced64ea2e55e3a28adafa4c5a557319e")),
        .package(url: "https://github.com/groue/Semaphore", .upToNextMinor(from: "0.0.6"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "DevstackKmpShared",
            path: "../DevstackKmpShared.xcframework"
        ),
        .target(
            name: "SharedDomain",
            dependencies: [
                "DevstackKmpShared",
                .product(name: "Semaphore", package: "Semaphore")
            ],
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-no_application_extension"])
            ]
        ),
        .target(
            name: "SharedDomainMocks",
            dependencies: [
                "SharedDomain",
                .product(name: "Resolver", package: "Resolver")
            ]
        ),
        .testTarget(
            name: "SharedDomainTests",
            dependencies: [
                "SharedDomain",
                "SharedDomainMocks"
            ]
        )
    ]
)
