// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TVDBKit",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "TVDBKit", targets: ["TVDBKit"]),
        .executable(name: "EpisodeLister", targets: ["EpisodeLister"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TVDBKit",
            dependencies: []),
        .testTarget(
            name: "TVDBKitTests",
            dependencies: ["TVDBKit"]),
        .executableTarget(
            name: "EpisodeLister",
            dependencies: ["TVDBKit"],
            swiftSettings: [
                .unsafeFlags([
                    "-parse-as-library"
                ])
            ]
        ),
    ]
)
