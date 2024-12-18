// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "vlc-player",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "vlc-player",
            targets: ["vlc-player"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/igorfedorchuk/vlckit-spm/", exact: "3.5.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "vlc-player", dependencies: [
                .product(name: "VLCKitSPM", package: "vlckit-spm"),
            ], resources: [.process("Resources")]
        ),
        .testTarget(
            name: "Tests",
            dependencies: ["vlc-player"]
        ),
    ]
)
