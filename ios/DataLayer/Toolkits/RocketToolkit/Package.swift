// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RocketToolkit",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RocketToolkit",
            targets: ["RocketToolkit"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "SharedDomain", path: "../../../DomainLayer/SharedDomain"),
        .package(name: "GraphQLProvider", path: "../../Providers/GraphQLProvider"),
        .package(url: "https://github.com/apollographql/apollo-ios", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RocketToolkit",
            dependencies: [
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "GraphQLProvider", package: "GraphQLProvider"),
                .product(name: "Apollo", package: "apollo-ios")
            ],
            resources: [
              .process("NetworkQueries")
            ]
        ),
        .target(
            name: "RocketToolkitMocks",
            dependencies: [
                "RocketToolkit",
                .product(name: "ApolloTestSupport", package: "apollo-ios")
            ]
        ),
        .testTarget(
            name: "RocketToolkitTests",
            dependencies: [
                "RocketToolkit",
                "RocketToolkitMocks",
                .product(name: "SharedDomain", package: "SharedDomain"),
                .product(name: "SharedDomainMocks", package: "SharedDomain"),
                .product(name: "GraphQLProvider", package: "GraphQLProvider"),
                .product(name: "GraphQLProviderMocks", package: "GraphQLProvider"),
                .product(name: "ApolloTestSupport", package: "apollo-ios")
            ]
        )
    ]
)
