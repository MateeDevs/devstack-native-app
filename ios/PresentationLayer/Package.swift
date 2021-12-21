// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PresentationLayer",
    defaultLocalization: "en",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PresentationLayer",
            targets: ["PresentationLayer"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "DomainLayer", path: "../DomainLayer"),
        .package(url: "https://github.com/Alamofire/AlamofireImage.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/MakeAWishFoundation/SwiftyMocky", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PresentationLayer",
            dependencies: [
                .product(name: "DomainLayer", package: "DomainLayer"),
                .product(name: "AlamofireImage", package: "AlamofireImage"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "SkeletonView", package: "SkeletonView")
            ]
        ),
        .testTarget(
            name: "PresentationLayerTests",
            dependencies: [
                "PresentationLayer",
                .product(name: "DomainStubs", package: "DomainLayer"),
                .product(name: "UseCaseMocks", package: "DomainLayer"),
                .product(name: "RxTest", package: "RxSwift"),
                .product(name: "SwiftyMocky", package: "SwiftyMocky")
            ]
        )
    ]
)
