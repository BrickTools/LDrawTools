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
            CommandLineOption(name: "--filter", description: "Filter color descriptions containing the specified word (case-insensitive)", numberOfParameters: 1),
            CommandLineOption(name: "-h", description: "Show this help")
        ]

        parser = CommandLineParser(options: options)
    }

    private func showHelp() -> Never {
        print("USAGE: LDColorList [options]")
        print("")
        print(parser.helpOptions())
        exit(0)
    }

    func run(with arguments: [String]) {
        var sortFunctions: [ColorSort] = []
        var filterFunctions: [ColorFilter] = []
        var outputType: OutputType = .list

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

        let ldraw = LDraw()
        var colors = ldraw.allColors()

        colors = sortFunctions.reduce(colors, applySort)
        colors = filterFunctions.reduce(colors, applyFilter)

        let output = outputType.convert(colors)
        print(output)
    }
}
