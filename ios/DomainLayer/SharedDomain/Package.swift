// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedDomain",
    platforms: [
        .iOS(.v15),
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
        .package(url: "https://github.com/Matejkob/swift-spyable", from: "0.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SharedDomain",
            dependencies: [
                "DevstackKmpShared",
                .product(name: "Spyable", package: "swift-spyable")
            ],
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-no_application_extension"])
            ]
//            plugins: [
//                "KMPBuildPlugin"
//            ]
        ),
        .target(
            name: "SharedDomainMocks",
            dependencies: [
                "SharedDomain",
                "DevstackKmpShared"
            ]
        ),
        .testTarget(
            name: "SharedDomainTests",
            dependencies: [
                "SharedDomain",
                "SharedDomainMocks"
            ]
        ),
//        .plugin(
//            name: "KMPBuildPlugin",
//            capability: .buildTool()
//        ),
        .plugin(
            name: "KMPBuildPlugin",
            capability: .command(
              intent: .custom(
                verb: "generate-kmp-binary",
                description: "Generates KMP xcframework"
              ),
              permissions: [
                .allowNetworkConnections(scope: .all(ports: []), reason: "This command needs to download gradle binaries"),
                //.writeToPackageDirectory(reason: "This command generates KMP xcframework")
              ]
            )
        ),
        .binaryTarget(
            name: "DevstackKmpShared",
            path: "../DevstackKmpShared.xcframework"
        )
    ]
)
