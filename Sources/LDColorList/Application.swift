import Foundation
import LDrawKit
import CommandLineKit

typealias ColorSort = (Color, Color) -> Bool
typealias ColorFilter = (Color) -> Bool

struct Application {
    private let parser: CommandLineParser

    init() {
        let options = [
            CommandLineOption(name: "-d", description: "Sort by description"),
            CommandLineOption(name: "-c", description: "Sort by code"),
            CommandLineOption(name: "--type", description: "Output format: json or list", numberOfParameters: 1),
            CommandLineOption(name: "--filter", description: "Filter out colors that don't contain the specified word (case-insensitive)", numberOfParameters: 1),
            CommandLineOption(name: "--ldraw", description: "Set the LDraw path", numberOfParameters: 1),
            CommandLineOption(name: "-h", description: "Show this help")
        ]

        parser = CommandLineParser(options: options)
    }

    func run(with arguments: [String]) {
        var sortFunctions: [ColorSort] = []
        var filterFunctions: [ColorFilter] = []
        var outputType: OutputType = .list
        var ldrawPath: String?

        parser.run(arguments: arguments) { option in
            switch option {
            case .success("-d", _):
                sortFunctions.append(byDescription)
            case .success("-c", _):
                sortFunctions.append(byCode)
            case .success("--type", let parameters):
                outputType = (parameters.first == "json") ? .json : .list
            case .success("--filter", let parameter):
                let descriptionFilter = descriptionContains(term: parameter.first!)
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
        var colors = ldraw.allColors()

        colors = sortFunctions.reduce(colors, applySort)
        colors = filterFunctions.reduce(colors, applyFilter)

        let output = outputType.convert(colors)
        print(output)
    }

    private func showHelp() -> Never {
        print("Usage: LDColorList [options]")
        print("\n\(parser.helpOptions)")
        exit(EXIT_SUCCESS)
    }
}
