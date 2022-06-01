// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BundleResourceFixPackage",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library( name: "BundleResourceFixPackage", targets: ["ModuleA", "ModuleB"]),
        .library(name: "ModuleUI", targets: ["ModuleUI"]),
        .plugin(name: "BundleCurrent", targets: ["BundleCurrent"]),
        .executable(name: "BundleCurrentCLI", targets: ["BundleCurrentCLI"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.1.2"),
    ],
    targets: [

        .target(
            name: "ModuleA",
            dependencies: [],
            resources: [.copy("Resources/A.png")], // https://stackoverflow.com/a/70456592/6043526
            plugins: ["BundleCurrent"]
        ),

            .target(
                name: "ModuleB",
                dependencies: [],
                resources: [.copy("Resources/B.png")], // https://stackoverflow.com/a/70456592/6043526
                plugins: ["BundleCurrent"]
            ),

            .target(name: "ModuleUI", dependencies: ["ModuleA", "ModuleB"]),

            .plugin(
                name: "BundleCurrent",
                capability: .buildTool(),
                dependencies: ["BundleCurrentCLI"]
            ),
        .executableTarget(name: "BundleCurrentCLI")
    ]
)
