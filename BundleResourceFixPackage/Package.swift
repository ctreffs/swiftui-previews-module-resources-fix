// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "BundleResourceFixPackage",
    platforms: [.iOS(.v15)],
    products: [
        .library( name: "BundleResourceFixPackage", targets: ["ModuleA", "ModuleB"]),
        .library(name: "ModuleUI", targets: ["ModuleUI"]),
        .plugin(name: "BundleCurrent", targets: ["BundleCurrent"]),
        .executable(name: "BundleCurrentCLI", targets: ["BundleCurrentCLI"])
    ],
    dependencies: [],
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
        .target(
            name: "ModuleUI",
            dependencies: ["ModuleA", "ModuleB"]
        ),
        // MARK: - Plugin
        .plugin(
            name: "BundleCurrent",
            capability: .buildTool(),
            dependencies: ["BundleCurrentCLI"]
        ),
        .executableTarget(
            name: "BundleCurrentCLI"
        )
    ]
)
