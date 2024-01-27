// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iAddThreeClassicKit",
    products: [
        .library(
            name: "iAddThreeClassicKit",
            targets: ["iAddThreeClassicKit"]),
    ],
    targets: [
        .binaryTarget(
            name: "iAddThreeClassicKit",
            url: "https://github.com/nikolainobadi/iAddThreeClassicKitXCFramework/releases/download/v0.9.5/iAddThreeClassicKit.xcframework.zip",
            checksum: "afbf9dc26a7972b348c1f1baf8f331d2151a80f8e5941bf077c927a45186028a"
        )
    ]
)
