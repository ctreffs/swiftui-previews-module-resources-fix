// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "BundleResourceFixPackage",
    platforms: [.iOS(.v15)],
    products: [
        .library( name: "BundleResourceFixPackage", targets: ["ModuleA", "ModuleB"]),
        .library(name: "ModuleUI", targets: ["ModuleUI"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ModuleA",
            dependencies: [],
            resources: [.copy("Resources/A.png")] // https://stackoverflow.com/a/70456592/6043526
        ),
        .target(
            name: "ModuleB",
            dependencies: [],
            resources: [.copy("Resources/B.png")] // https://stackoverflow.com/a/70456592/6043526
        ),
        .target(
            name: "ModuleUI",
            dependencies: ["ModuleA", "ModuleB"]
        )
    ]
)
