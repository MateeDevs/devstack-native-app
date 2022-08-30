// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteConfigToolkit",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RemoteConfigToolkit",
            targets: ["RemoteConfigToolkit"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "SharedDomain", path: "../../DomainLayer/SharedDomain"),
        .package(name: "RemoteConfigProvider", path: "../Providers/RemoteConfigProvider")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RemoteConfigToolkit",
            dependencies: [
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "RemoteConfigProvider", package: "RemoteConfigProvider")
            ]
        ),
        .testTarget(
            name: "RemoteConfigToolkitTests",
            dependencies: [
                "RemoteConfigToolkit",
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "RemoteConfigProvider", package: "RemoteConfigProvider"),
                .product(name: "RemoteConfigProviderMocks", package: "RemoteConfigProvider")
            ]
        )
    ]
)
