// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserToolkit",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UserToolkit",
            targets: ["UserToolkit"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Utilities", path: "../../../DomainLayer/Utilities"),
        .package(name: "SharedDomain", path: "../../../DomainLayer/SharedDomain"),
        .package(name: "DatabaseProvider", path: "../../Providers/DatabaseProvider"),
        .package(name: "NetworkProvider", path: "../../Providers/NetworkProvider")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "UserToolkit",
            dependencies: [
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "DatabaseProvider", package: "DatabaseProvider"),
                .product(name: "NetworkProvider", package: "NetworkProvider")
            ]
        ),
        .testTarget(
            name: "UserToolkitTests",
            dependencies: [
                "UserToolkit",
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "SharedDomainMocks", package: "SharedDomain"),
                .product(name: "DatabaseProvider", package: "DatabaseProvider"),
                .product(name: "DatabaseProviderMocks", package: "DatabaseProvider"),
                .product(name: "NetworkProvider", package: "NetworkProvider"),
                .product(name: "NetworkProviderMocks", package: "NetworkProvider")
            ],
            resources: [
              .process("NetworkStubs")
            ]
        )
    ]
)
