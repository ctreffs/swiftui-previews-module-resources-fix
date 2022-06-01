import Foundation

public struct ModuleB {
    public let resourceURL: URL

    public init() {
        resourceURL = Bundle.current.url(forResource: "B", withExtension: "png")!
    }
}
