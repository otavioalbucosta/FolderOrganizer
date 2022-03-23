// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FolderOrganizer",
    platforms: [.macOS(.v10_12)],
    products: [
        .library(name: "FolderOrganizerLib", targets:["FolderOrganizerLib"]),
        .executable(name: "FolderOrganizer", targets: ["FolderOrganizer"])
    ],
    
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "swift-argument-parser",url: "https://github.com/apple/swift-argument-parser", from: "0.0.1")
    ],
    targets: [

        .target(name: "FolderOrganizerLib",
                dependencies: [
                    .product(
                    name: "ArgumentParser", package: "swift-argument-parser")
                ]),
        .executableTarget(
            name: "FolderOrganizer",
            dependencies: ["FolderOrganizerLib"]),
        .testTarget(
            name: "FolderOrganizerTests",
            dependencies: ["FolderOrganizer"]),
    ]
)
