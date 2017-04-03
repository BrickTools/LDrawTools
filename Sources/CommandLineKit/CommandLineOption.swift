import Foundation

public struct CommandLineOption {
    public let name: String
    public let description: String
    public let numberOfParameters: Int

    public init(name: String, description: String, numberOfParameters: Int = 0) {
        self.name = name
        self.description = description
        self.numberOfParameters = numberOfParameters
    }
}
