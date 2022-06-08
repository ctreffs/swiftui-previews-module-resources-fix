import Foundation

public struct ModuleA {
    public let resourceURL: URL

    public init() {
        resourceURL = Bundle.module.url(forResource: "A", withExtension: "png")!
    }
}
