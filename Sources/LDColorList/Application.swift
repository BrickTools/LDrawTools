import Foundation
import LDrawKit

typealias ColorSort = (Color, Color) -> Bool

struct Application {
    private func showHelp() -> Never {
        print("USAGE: LDColorList [options]")
        print("")
        print("OPTIONS:")
        print("  -d\tSort by description")
        print("  -c\tSort by code")
        print("  -j\tPrint as JSON")
        print("  -h/-?\tShow this help")
        exit(0)
    }

    func run(with arguments: [String]) {
        var sortFunctions: [ColorSort] = []
        var outputType: OutputType = .text

        for argument in arguments {
            switch argument {
            case "-d":
                sortFunctions.append(byDescription)

            case "-c":
                sortFunctions.append(byCode)

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
        var colors = ldraw.allColors()

        colors = sortFunctions.reduce(colors, applySort)

        let output = outputType.toString(colors: colors)
        print(output)
    }
}
