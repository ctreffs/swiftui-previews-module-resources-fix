import Foundation
import PackagePlugin

@main
struct BundleCurrentPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {

        let tool = try context.tool(named: "BundleCurrentCLI")

        guard let sourceModuleTarget = target as? SwiftSourceModuleTarget, sourceModuleTarget.hasResources else {
            return []
        }

        let targetName = sourceModuleTarget.name
        let packageName = context.package.displayName
        let workingDir = context.pluginWorkDirectory

        let bundleName = "\(packageName)_\(targetName)"
        let outputDir: Path = workingDir.appending(bundleName)
        let outputFilePath: Path = outputDir.appending("bundle_current.swift")

        let content = generateBundleExtensionSwift(packageName: packageName,
                                                   targetName: targetName)

        do {
            try FileManager.default.createDirectory(at: URL(fileURLWithPath: outputDir.string),
                                                    withIntermediateDirectories: true)

            try content.write(toFile: outputFilePath.string,
                              atomically: true,
                              encoding: .utf8)

            return [.prebuildCommand(displayName: targetName,
                                     executable: tool.path,
                                     arguments: [],
                                     outputFilesDirectory: outputDir)]
        } catch {
            Diagnostics.error("\(error)")
            return []
        }

    }
}

extension SwiftSourceModuleTarget {
    var hasResources: Bool { sourceFiles.contains { $0.type == .resource } }
}

// https://developer.apple.com/forums/thread/664295?answerId=673644022#673644022
// https://gist.github.com/ctreffs/ad9d23e08d586cf75e4d1c3bb1b1061f
func generateBundleExtensionSwift(packageName: String, targetName: String) -> String {
    """
    import class Foundation.Bundle
    import class Foundation.ProcessInfo

    private class BundleFinder {}

    extension Foundation.Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var current: Bundle = {
        let bundleName = "\(packageName)_\(targetName)"

        var candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,
        ]

        // FIX FOR PREVIEWS
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            candidates.append(contentsOf: [
                // Bundle should be present here when running previews from a different package
                Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
                Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent()
            ])
        }

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(packageName)_\(targetName)")
    }()
    }

    """
}
