// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DomainLayer",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DomainLayer",
            targets: ["DomainLayer"]
        ),
        .library(
            name: "DomainStubs",
            targets: ["DomainStubs"]
        ),
        .library(
            name: "UseCaseMocks",
            targets: ["UseCaseMocks"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/MakeAWishFoundation/SwiftyMocky", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/hmlongco/Resolver.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "DevstackKmpShared",
            path: "./DevstackKmpShared.xcframework"
        ),
        .target(
            name: "DomainLayer",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "Resolver", package: "Resolver"),
                "DevstackKmpShared"
            ]
        ),
        .target(
            name: "DomainStubs",
            dependencies: [
                "DomainLayer"
            ]
        ),
        .target(
            name: "UseCaseMocks",
            dependencies: [
                "DomainLayer",
                .product(name: "SwiftyMocky", package: "SwiftyMocky")
            ]
        ),
        .target(
            name: "RepositoryMocks",
            dependencies: [
                "DomainLayer",
                .product(name: "SwiftyMocky", package: "SwiftyMocky")
            ]
        ),
        .testTarget(
            name: "DomainLayerTests",
            dependencies: [
                "DomainStubs",
                "RepositoryMocks",
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxTest", package: "RxSwift"),
                .product(name: "SwiftyMocky", package: "SwiftyMocky")
            ]
        )
    ]
)
