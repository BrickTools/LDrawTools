import Foundation

public enum CommandLineParsedOption {
    case success(commandName: String, parameters: [String])
    case failure(commandName: String)
}
