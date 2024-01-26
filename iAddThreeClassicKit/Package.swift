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
            url: "https://github.com/nikolainobadi/iAddThreeClassicKitXCFramework/releases/download/v0.8.0/iAddThreeClassicKit.xcframework.zip",
            checksum: "5bbc4a68bc529cc8615a03b804f27fee3c371d45d0691c9c0557e146c6e6bd26"
        )
    ]
)
