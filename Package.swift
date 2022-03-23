// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FolderOrganizer",
    platforms: [.macOS(.v10_12)],
    products: [
        .library(name: "FolderOrganizerLib", targets:["FolderOrganizerLib"]),
        .executable(name: "folder-organizer", targets: ["folder-organizer"])
    ],
    
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "swift-argument-parser",url: "https://github.com/apple/swift-argument-parser", from: "1.0.0")
    ],
    targets: [

        .target(name: "FolderOrganizerLib",
                dependencies: [
                    .product(
                    name: "ArgumentParser", package: "swift-argument-parser")
                ]),
        .executableTarget(
            name: "folder-organizer",
            dependencies: ["FolderOrganizerLib"]),
        .testTarget(
            name: "FolderOrganizerTests",
            dependencies: ["FolderOrganizerLib"]),
    ]
)
