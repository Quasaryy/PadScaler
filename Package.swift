// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PadScaler",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "PadScaler",
            targets: ["PadScaler"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PadScaler",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        ),
    ]
)
