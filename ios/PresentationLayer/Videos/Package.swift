// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Videos",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Videos",
            targets: ["Videos"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "UIToolkit", path: "../UIToolkit"),
        .package(name: "MapToolkit", path: "../MapToolkit"),
        .package(name: "Utilities", path: "../../DomainLayer/Utilities"),
        .package(name: "SharedDomain", path: "../../DomainLayer/SharedDomain"),
        .package(name: "DependencyInjection", path: "../../Application/DependencyInjection"),
        .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.3.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Videos",
            dependencies: [
                .product(name: "UIToolkit", package: "UIToolkit"),
                .product(name: "MapToolkit", package: "MapToolkit"),
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "DependencyInjection", package: "DependencyInjection"),
                .product(name: "DependencyInjectionMocks", package: "DependencyInjection"),
                .product(name: "Factory", package: "Factory")
            ]
        ),
        .testTarget(
            name: "VideosTests",
            dependencies: [
                "Videos",
                .product(name: "UIToolkit", package: "UIToolkit"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "SharedDomainMocks", package: "SharedDomain"),
                .product(name: "DependencyInjection", package: "DependencyInjection"),
                .product(name: "Factory", package: "Factory")
            ]
        ),
    ]
)
