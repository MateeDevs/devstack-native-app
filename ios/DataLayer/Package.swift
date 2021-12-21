// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataLayer",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DataLayer",
            targets: ["DataLayer"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "DomainLayer", path: "../DomainLayer"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "8.0.0")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/realm/realm-cocoa.git", .upToNextMajor(from: "10.0.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxRealm.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/MakeAWishFoundation/SwiftyMocky", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DataLayer",
            dependencies: [
                .product(name: "DomainLayer", package: "DomainLayer"),
                .product(name: "FirebaseAnalyticsWithoutAdIdSupport", package: "firebase-ios-sdk"),
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
                .product(name: "Moya", package: "Moya"),
                .product(name: "RxMoya", package: "Moya"),
                .product(name: "Realm", package: "realm-cocoa"),
                .product(name: "RealmSwift", package: "realm-cocoa"),
                .product(name: "RxRealm", package: "RxRealm"),
                .product(name: "RxSwift", package: "RxSwift")
            ],
            resources: [
              .process("NetworkStubs")
            ]
        ),
        .target(
            name: "ProviderMocks",
            dependencies: [
                "DataLayer",
                .product(name: "SwiftyMocky", package: "SwiftyMocky")
            ]
        ),
        .testTarget(
            name: "DataLayerTests",
            dependencies: [
                "ProviderMocks",
                .product(name: "DomainStubs", package: "DomainLayer"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxTest", package: "RxSwift"),
                .product(name: "SwiftyMocky", package: "SwiftyMocky")
            ]
        )
    ]
)
