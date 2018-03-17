// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "LanguageServerProtocol",
    products: [
        .library(
            name: "LanguageServerProtocol",
            targets: ["LanguageServerProtocol"]),
    ],
    dependencies: [
        .package(url: "https://github.com/theguild/json-swift.git", from: "4.0.0"),
    ],
    targets: [
        .target(name: "LanguageServerProtocol", dependencies: ["JSONLib"]),
        .target(name: "JsonRpcProtocol", dependencies: ["LanguageServerProtocol"])
    ]
)
