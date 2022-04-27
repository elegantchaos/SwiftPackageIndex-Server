// swift-tools-version:5.5

// Copyright 2020-2021 Dave Verwer, Sven A. Schmidt, and other contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import PackageDescription

let package = Package(
    name: "SPI-Server",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(name: "DependencyResolution", targets: ["DependencyResolution"])
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0-rc"),
        .package(url: "https://github.com/JohnSundell/Ink.git", from: "0.5.1"),
        .package(url: "https://github.com/JohnSundell/Plot.git", from: "0.10.0"),
        .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0"),
        .package(url: "https://github.com/MrLotU/SwiftPrometheus.git", from: "1.0.0-alpha"),
        .package(url: "https://github.com/pointfreeco/swift-parsing.git", from: "0.7.1"),
        .package(name: "SnapshotTesting",
                 url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.7.2"),
        .package(url: "git@github.com:pointfreeco/vapor-routing.git", from: "0.0.0"),
        .package(url: "https://github.com/SwiftPackageIndex/SemanticVersion", from: "0.3.0"),
        .package(url: "https://github.com/handya/OhhAuth.git", from: "1.4.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.3.2"),
        .package(name: "SwiftPM", url: "https://github.com/apple/swift-package-manager.git",
                 .branch("release/5.6"))
    ],
    targets: [
        .target(name: "App", dependencies: [
            "DependencyResolution",
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            .product(name: "Vapor", package: "vapor"),
            "Plot",
            "Ink",
            "SemanticVersion",
            "ShellOut",
            "SwiftPrometheus",
            "OhhAuth",
            "SwiftSoup",
            .product(name: "SwiftPMPackageCollections", package: "SwiftPM"),
            .product(name: "VaporRouting", package: "vapor-routing")
        ]),
        .target(name: "DependencyResolution"),
        .executableTarget(name: "Run", dependencies: ["App"]),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .target(name: "App"),
                .product(name: "XCTVapor", package: "vapor"),
                .product(name: "Parsing", package: "swift-parsing"),
                "SnapshotTesting"
            ],
            exclude: ["__Snapshots__", "Fixtures"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
