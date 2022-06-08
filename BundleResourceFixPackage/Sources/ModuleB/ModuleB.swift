import Foundation

public struct ModuleB {
    public let resourceURL: URL

    public init() {
        resourceURL = Bundle.module.url(forResource: "B", withExtension: "png")!
    }
}
