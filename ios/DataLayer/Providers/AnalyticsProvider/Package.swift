// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnalyticsProvider",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AnalyticsProvider",
            targets: ["AnalyticsProvider"]
        ),
        .library(
            name: "AnalyticsProviderMocks",
            targets: ["AnalyticsProviderMocks"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "10.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AnalyticsProvider",
            dependencies: [
                .product(name: "FirebaseAnalyticsWithoutAdIdSupport", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk")
            ]
        ),
        .target(
            name: "AnalyticsProviderMocks",
            dependencies: [
                "AnalyticsProvider"
            ]
        )
    ]
)
