import Foundation
import LDrawKit
import CommandLineKit

typealias PartSort = (Part, Part) -> Bool
typealias PartFilter = (Part) -> Bool

struct Application {
    private let parser: CommandLineParser

    init() {
        let options = [
            CommandLineOption(name: "-d", description: "Sort by description"),
            CommandLineOption(name: "-n", description: "Sort by file name"),
            CommandLineOption(name: "-m", description: "Ignore parts that moved (~ Moved to...)"),
            CommandLineOption(name: "-~", description: "Ignore parts that start with tilde (~)"),
            CommandLineOption(name: "-_", description: "Ignore parts that start with _"),
            CommandLineOption(name: "-=", description: "Ignore parts that start with ="),
            CommandLineOption(name: "--type", description: "Output format: either json or list", numberOfParameters: 1),
            CommandLineOption(name: "--filter", description: "Filter out parts that don't contain the specified word (case-insensitive)", numberOfParameters: 1),
            CommandLineOption(name: "--ldraw", description: "Set the LDraw path", numberOfParameters: 1),
            CommandLineOption(name: "-h", description: "Show this help")
        ]

        parser = CommandLineParser(options: options)
    }

    func run(with arguments: [String]) {
        var sortFunctions: [PartSort] = []
        var filterFunctions: [PartFilter] = []
        var outputType: OutputType = .list
        var ldrawPath: String?

        parser.run(arguments: arguments) { option in
            switch option {
            case .success("-d", _):
                sortFunctions.append(byDescription)
            case .success("-n", _):
                sortFunctions.append(byFileName)
            case .success("-m", _):
                filterFunctions.append(hasNotMoved)
            case .success("-~", _):
                filterFunctions.append(noPrefix(string: "~"))
            case .success("-_", _):
                filterFunctions.append(noPrefix(string: "_"))
            case .success("-=", _):
                filterFunctions.append(noPrefix(string: "="))
            case .success("--type", let parameters):
                outputType = (parameters.first == "json") ? .json : .list
            case .success("--filter", let parameter):
                let descriptionFilter = descriptionContains(string: parameter.first!)
                filterFunctions.append(descriptionFilter)
            case .success("--ldraw", let parameters):
                ldrawPath = parameters.first!
            case .success("-h", _):
                showHelp()
            case .failure(let commandName):
                print("\(commandName) doesn't have the correct number of arguments")
                showHelp()
            default:
                showHelp()
                break
            }
        }

        let ldraw = LDraw(path: ldrawPath ?? ".")
        var parts = ldraw.allParts()

        parts = filterFunctions.reduce(parts, applyFilter)
        parts = sortFunctions.reduce(parts, applySort)

        let output = outputType.convert(parts)
        print(output)
    }

    private func showHelp() -> Never {
        print("Usage: LDPartList [options]")
        print("\n\(parser.helpOptions)")
        exit(EXIT_FAILURE)
    }
}
