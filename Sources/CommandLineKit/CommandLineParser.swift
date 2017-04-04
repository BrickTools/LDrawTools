import Foundation

public struct CommandLineParser {
    let options: [CommandLineOption]

    public init(options: [CommandLineOption]) {
        self.options = options
    }

    public func run(arguments: [String], callback: (CommandLineParsedOption) -> Void) {
        let optionNames = options.map { $0.name }

        let parsedOptions = arguments
            .reduce([], toCommandLineValues(matching: optionNames))
            .flatMap(toCommandLineParsedOptions(matching: options))

        for option in parsedOptions {
            callback(option)
        }
    }

    public func helpOptions() -> String? {
        guard let longestOption = options.max(by: byOptionNameLength) else { return nil }

        return options.reduce("Options:") {
            $0 + "\n" + $1.name.padding(toLength: longestOption.name.characters.count + 2, withPad: " ", startingAt: 0) + $1.description
        }
    }
}
