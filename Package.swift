// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TheMovieDBKit",
    products: [
        .library(name: "TheMovieDBKit", targets: ["TheMovieDBKit"]),
        .executable(name: "EpisodeLister", targets: ["EpisodeLister"])
    ],
    targets: [
        .target(
            name: "TheMovieDBKit",
            dependencies: []),
        .testTarget(
            name: "TheMovieDBKitTests",
            dependencies: ["TheMovieDBKit"]),
        .executableTarget(
            name: "EpisodeLister",
            dependencies: ["TheMovieDBKit"],
            swiftSettings: [
                .unsafeFlags([
                    "-parse-as-library"
                ])
            ]
        ),
    ]
)
