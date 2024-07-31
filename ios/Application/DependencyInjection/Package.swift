// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjection",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DependencyInjection",
            targets: ["DependencyInjection"]
        ),
        .library(
            name: "DependencyInjectionMocks",
            targets: ["DependencyInjectionMocks"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        
        .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.3.0")),
        .package(name: "SharedDomain", path: "../../DomainLayer/SharedDomain"),
        .package(name: "Utilities", path: "../../DomainLayer/Utilities"),
        
        // Toolkits
        .package(name: "AnalyticsToolkit", path: "../../DataLayer/Toolkits/AnalyticsToolkit"),
        
        // Providers
        .package(name: "AnalyticsProvider", path: "../../DataLayer/Providers/AnalyticsProvider"),
        .package(name: "KeychainProvider", path: "../../DataLayer/Providers/KeychainProvider"),
        .package(name: "NetworkProvider", path: "../../DataLayer/Providers/NetworkProvider"),
        .package(name: "UserDefaultsProvider", path: "../../DataLayer/Providers/UserDefaultsProvider")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DependencyInjection",
            dependencies: [
                .product(name: "Factory", package: "Factory"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "Utilities", package: "Utilities"),
                
                // Toolkits
                .product(name: "AnalyticsToolkit", package: "AnalyticsToolkit"),
                
                // Providers
                .product(name: "AnalyticsProvider", package: "AnalyticsProvider"),
                .product(name: "KeychainProvider", package: "KeychainProvider"),
                .product(name: "NetworkProvider", package: "NetworkProvider"),
                .product(name: "UserDefaultsProvider", package: "UserDefaultsProvider")
            ]
        ),
        .target(
            name: "DependencyInjectionMocks",
            dependencies: [
                "DependencyInjection",
                .product(name: "Factory", package: "Factory"),
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "SharedDomainMocks", package: "SharedDomain")
            ]
        )
    ]
)
