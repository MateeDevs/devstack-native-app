// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnalyticsToolkit",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AnalyticsToolkit",
            targets: ["AnalyticsToolkit"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Utilities", path: "../../../DomainLayer/Utilities"),
        .package(name: "SharedDomain", path: "../../../DomainLayer/SharedDomain"),
        .package(name: "AnalyticsProvider", path: "../../Providers/AnalyticsProvider")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AnalyticsToolkit",
            dependencies: [
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "AnalyticsProvider", package: "AnalyticsProvider")
            ]
        ),
        .testTarget(
            name: "AnalyticsToolkitTests",
            dependencies: [
                "AnalyticsToolkit",
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "AnalyticsProvider", package: "AnalyticsProvider"),
                .product(name: "AnalyticsProviderMocks", package: "AnalyticsProvider")
            ]
        )
    ]
)
