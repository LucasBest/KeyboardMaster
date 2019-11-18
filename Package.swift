// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "KeyboardMaster",
    platforms: [
        .iOS(.v10),
    ], products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "KeyboardMaster",
            targets: ["KeyboardMaster"]),
    ],
    targets: [
        .target(
            name: "KeyboardMaster",
            path: "KeyboardMaster/Classes/"),
        .testTarget(
            name: "KeyboardMasterTests",
            dependencies: ["KeyboardMaster"],
            path: "Example/Tests/"),
    ]
)
