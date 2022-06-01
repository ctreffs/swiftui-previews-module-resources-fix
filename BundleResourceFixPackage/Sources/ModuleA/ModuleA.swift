import Foundation

public struct ModuleA {
    public let resourceURL: URL

    public init() {
        resourceURL = Bundle.current.url(forResource: "A", withExtension: "png")!
    }
}
