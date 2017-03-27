import Foundation

func hasName(_ name: String) -> (CommandLineOption) -> Bool {
    return { option in option.name == name }
}

func toCommandLineValues(matching names: [String]) -> ([CommandLineValue], String) -> [CommandLineValue] {
    return { initial, element in
        var previous = initial

        if names.contains(element) {
            return previous + [CommandLineValue(name: element, parameters: [])]
        } else {
            if initial.count > 0 {
                let last = previous.removeLast()
                return previous + [CommandLineValue(name: last.name, parameters: last.parameters + [element])]
            }

            return initial
        }
    }
}

func toCommandLineParsedOptions(matching options: [CommandLineOption]) -> (CommandLineValue) -> CommandLineParsedOption? {
    return { commandLineValue in
        guard let option = options.first(where: hasName(commandLineValue.name)) else { return nil }

        if option.numberOfParameters == commandLineValue.parameters.count {
            return .success(commandName: commandLineValue.name, parameters: commandLineValue.parameters)
        } else {
            return .failure(commandName: commandLineValue.name)
        }
    }
}
