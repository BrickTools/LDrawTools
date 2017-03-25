import Foundation
import LDrawKit

typealias PartSort = (Part, Part) -> Bool
typealias PartFilter = (Part) -> Bool

struct Application {
    private func showHelp() -> Never {
        print("USAGE: LDMakeList [options]")
        print("")
        print("OPTIONS:")
        print("  -d\tSort by description")
        print("  -n\tSort by file name")
        print("  -m\tIgnore parts that moved (~ Moved to...)")
        print("  -~\tIgnore parts that start with tilde (~)")
        print("  -_\tIgnore parts that start with _")
        print("  -=\tIgnore parts that start with =")
        print("  -j\tPrint as JSON")
        print("  -h/-?\tShow this help")
        exit(0)
    }

    func run(with arguments: [String]) {
        var sortFunctions: [PartSort] = []
        var filterFunctions: [PartFilter] = []
        var outputType: OutputType = .text

        for argument in arguments {
            switch argument {
            case "-d":
                sortFunctions.append(byDescription)

            case "-n":
                sortFunctions.append(byFileName)

            case "-m":
                filterFunctions.append(hasNotMoved)

            case "-~":
                filterFunctions.append(noPrefix(string: "~"))

            case "-_":
                filterFunctions.append(noPrefix(string: "_"))

            case "-=":
                filterFunctions.append(noPrefix(string: "="))

            case "-j":
                outputType = .json

            case "-h":
                showHelp()

            case "-?":
                showHelp()

            default:
                break
            }
        }

        let ldraw = LDraw()
        var parts = ldraw.allParts()

        parts = filterFunctions.reduce(parts, applyFilter)
        parts = sortFunctions.reduce(parts, applySort)

        let output = outputType.toString(parts: parts)
        print(output)
    }
}
