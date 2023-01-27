// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RaceDetail",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RaceDetail",
            targets: ["RaceDetail"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "SharedDomain", path: "../DomainLayer/SharedDomain"),
        .package(name: "UIToolkit", path: "./UIToolkit"),
        .package(name: "Utilities", path: "../DomainLayer/Utilities"),
        .package(url: "https://github.com/hmlongco/Resolver.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RaceDetail",
            dependencies: [
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "UIToolkit", package: "UIToolkit"),
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "Resolver", package: "Resolver")
            ]
        )
    ]
)
