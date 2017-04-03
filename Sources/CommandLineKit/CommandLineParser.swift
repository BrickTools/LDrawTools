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

    public func helpOptions() -> String {
        return options.reduce("OPTIONS:") {
            $0 + "\n" + $1.name.padding(toLength: 8, withPad: " ", startingAt: 0) + $1.description
        }
    }
}
